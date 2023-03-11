class Teip < Formula
  desc "Masking tape to help commands \"do one thing well\""
  homepage "https://github.com/greymd/teip"
  url "https://github.com/greymd/teip/archive/v2.3.0.tar.gz"
  sha256 "4c39466613f39d27fa22ae2a6309ac732ea94fdbc8711ecd4149fc1ecdfbaedf"
  license "MIT"
  head "https://github.com/greymd/teip.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--features", "oniguruma", *std_cargo_args
    man1.install "man/teip.1"
    zsh_completion.install "completion/zsh/_teip"
    fish_completion.install "completion/fish/teip.fish"
    bash_completion.install "completion/bash/teip"
  end

  test do
    ENV["TEIP_HIGHLIGHT"] = "<{}>"
    assert_match /AAA/, pipe_output("#{bin}/teip -c 1", "<A>AA", 0)
  end
end
