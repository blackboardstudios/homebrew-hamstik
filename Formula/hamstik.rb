class Hamstik < Formula
  desc "Official command-line interface for Hamstik"
  homepage "https://hamstik.com"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.6.0/hamstik-cli-aarch64-apple-darwin.tar.gz"
      sha256 "2aa0a7e4b4d3ecdf87858379a2cdfb645150dd9d03bb105680f47513246b6de4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.6.0/hamstik-cli-x86_64-apple-darwin.tar.gz"
      sha256 "26d5ac06f58354228b17062f376e09a492d9a75ad1a92b534d126681300e31ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.6.0/hamstik-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "92cb5183a7da647ead723b3070fe69d9aaee881563b596bbfb51c9f1590bd02e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.6.0/hamstik-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "60f601bcd780d294c99e1783cc9d64714a2b51a63e3195763ab001a33e4bed04"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
