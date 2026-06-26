class Me < Formula
  desc "Local meaning environment"
  homepage "https://github.com/inshell-art/me"
  url "https://github.com/inshell-art/me/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "e16fccf4a69b66e4abc5cca04bd6f5d9b1737587b6e6b0a25361754c39c311e8"
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
