class Me < Formula
  desc "Local meaning environment"
  homepage "https://github.com/inshell-art/me"
  url "https://github.com/inshell-art/me/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "40d5dffc979568f86a1b5b7c18765ff8c99be356920c7e4951a4e92415467f2b"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/me-cli")
  end

  test do
    assert_match "ME", shell_output("#{bin}/me --version")
    workspace = testpath/"ME"
    system bin/"me", "new", workspace
    assert_path_exists workspace/"me.toml"
    assert_path_exists workspace/".me/refs/current"
    assert_path_exists workspace/".agents/skills/me/SKILL.md"
    system bin/"me", "--workspace", workspace, "fsck"
  end
end
