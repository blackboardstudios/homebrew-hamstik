class Hamstik < Formula
  desc "Official command-line interface for Hamstik"
  homepage "https://hamstik.com"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.5.0/hamstik-cli-aarch64-apple-darwin.tar.gz"
      sha256 "f496846b1872407d32758dd0fbfb95390b278e6bd3d15d27a910d2799ff76df3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.5.0/hamstik-cli-x86_64-apple-darwin.tar.gz"
      sha256 "d9979791887eec96a3dd5bdf910f0183996183736e599e150b2be60a63f5efb8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.5.0/hamstik-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6cb889024a42113e61dcbd658fb467f9ba3488da4b07b177b0fb18989c6ae7a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.5.0/hamstik-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1386ef2f16952476bd9a9ebd21798634ed46271e48eec8030ecea7a65d0e5e38"
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
