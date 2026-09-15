class HamstikCli < Formula
  desc "Official command-line interface for Hamstik"
  homepage "https://hamstik.com"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.1/hamstik-cli-aarch64-apple-darwin.tar.gz"
      sha256 "2a8996e99bfe37234d363c8163f25017acf85636fadee255dfa5df5bc71f8067"
    end
    if Hardware::CPU.intel?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.1/hamstik-cli-x86_64-apple-darwin.tar.gz"
      sha256 "a339c963cf91615b74caf715f11411a6ccbd14bdda282f15d8ed663c7c512b07"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.1/hamstik-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "34cbfb2e73a8438842f589a1e9d20ed6b868717b81f12825e8975efa818a9eb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.1/hamstik-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aac002282b3186041bb2f6c5694f5f8446930d5f0318d0c1b92625ec36f3b005"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hamstik"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hamstik"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hamstik"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hamstik"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
