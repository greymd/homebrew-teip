class Teip < Formula
  desc "Masking tape to help commands \"do one thing well\""
  homepage "https://github.com/greymd/teip"
  url "https://github.com/greymd/teip/archive/v2.2.0.tar.gz"
  sha256 "11816abcecaebc8aa1dc8131387baa4030ba7e9f48994733c091b04a2c992381"
  license "MIT"
  head "https://github.com/greymd/teip.git", branch: "main"

  depends_on "rust" => :build

  def install
    ENV["SHELL_COMPLETIONS_DIR"] = buildpath
    system "cargo", "install", "--features", "oniguruma", *std_cargo_args
    man1.install "man/teip.1"
    zsh_completion.install "completion/zsh/_teip"
    fish_completion.install "completion/fish/teip.fish"
    bash_completion.install "completion/bash/teip"
  end

  test do
    ENV["TEIP_HIGHLIGHT"] = "<{}>"
    assert_match /AAA/, pipe_output("#{bin}/teip -c 1", "<A>AA", 0)
    # Invalid option
    pipe_output("#{bin}/teip -c 2-1", "test", 1)
  end
end
