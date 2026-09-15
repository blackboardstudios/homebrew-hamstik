class Hamstik < Formula
  desc "Official command-line interface for Hamstik"
  homepage "https://hamstik.com"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.2/hamstik-cli-aarch64-apple-darwin.tar.gz"
      sha256 "c7f1db5d284ed9c781370caf6e0376dc09d69060a998b20f2e879179a8267e66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.2/hamstik-cli-x86_64-apple-darwin.tar.gz"
      sha256 "7f62196479c8e8d619c491f1d41cc4ff0efb282d1b102765bf98133349c5c2af"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.2/hamstik-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "edc78a6ce87500e9dd63c1ac00f39c7c5b72d060bf2f4db5584976a727e0d8c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.2/hamstik-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "02ccadb6cb347dbe9b1bac6c1f56622d4d976b9f62c53405deb36da16254362a"
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
