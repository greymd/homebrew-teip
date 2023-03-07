class Teip < Formula
  version "2.2.0"
  desc "Masking tape to help commands \"do one thing well\""
  homepage "https://github.com/greymd/teip"

  # 64-bit ARM version for Apple Silicon
  if Hardware::CPU.arm?
    url "https://github.com/greymd/teip/releases/download/v#{version}/teip-#{version}.aarch64-apple-darwin.tar.gz"
    sha256 "e403b493daf6a97a2ef91df444ba4a292f96f1d4764c3e667e6710c4fbeb321c"
  else
    url "https://github.com/greymd/teip/releases/download/v#{version}/teip-#{version}.x86_64-apple-darwin.tar.gz"
    sha256 "ef041adf0699cd4ba05b4ba76de2ea94847fbd8c12f9b83142ae904f8f551a81"
  end

  def install
    bin.install "bin/teip"
    man1.install "man/teip.1"
    zsh_completion.install "completion/zsh/_teip"
    fish_completion.install "completion/fish/teip.fish"
    bash_completion.install "completion/bash/teip"
  end

  test do
    assert_match /BBA\nBBB/, pipe_output("#{bin}/teip -c 1-2 -- tr A B", "AAA\nBBB", 0)

    # Invalid option
    pipe_output("#{bin}/teip -c 2-1", "test", 1)
  end
end
