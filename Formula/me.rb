class Me < Formula
  desc "Local meaning environment"
  homepage "https://github.com/inshell-art/me"
  url "https://github.com/inshell-art/me/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "b7466494d03ecb0c75a90410ecc962d71606a4d695ff34a0c06a9fd7d0063a62"
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
