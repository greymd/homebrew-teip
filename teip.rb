class Teip < Formula
  desc 'Masking tape to help commands "do one thing well"'
  homepage "https://github.com/greymd/teip-test"
  url "https://github.com/greymd/teip-test/archive/v2.3.2.tar.gz"
  sha256 "493c220d662463e9f5e1bc93be38c26f097b70d44d0f8e0e8f8e939758dee399"
  license "MIT"
  head "https://github.com/greymd/teip.git", branch: "main"

  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "oniguruma" => :build

  def install
    ENV["RUSTONIG_DYNAMIC_LIBONIG"] = "1"
    ENV["RUSTONIG_SYSTEM_LIBONIG"] = "1"
    system "cargo", "install", "--features", "oniguruma", *std_cargo_args
    man1.install "man/teip.1"
    zsh_completion.install "completion/zsh/_teip"
    fish_completion.install "completion/fish/teip.fish"
    bash_completion.install "completion/bash/teip"
  end

  test do
    ENV["TEIP_HIGHLIGHT"] = "<{}>"
    assert_match "<1>23", pipe_output("#{bin}/teip -c 1", "123", 0)
  end
end
