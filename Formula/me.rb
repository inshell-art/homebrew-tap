class Me < Formula
  desc "Local meaning environment"
  homepage "https://github.com/inshell-art/me"
  url "https://github.com/inshell-art/me/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "a799c308ac1c21213ec653ba898203864cdc9467b8af5a6e5fa9a79b6fb2b4b2"
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
