class Hamstik < Formula
  desc "Official command-line interface for Hamstik"
  homepage "https://hamstik.com"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.3/hamstik-cli-aarch64-apple-darwin.tar.gz"
      sha256 "217b4cf7feabd5eef6fb702452f7cc2bf63ef64f0467fade167f0ddb41116f7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.3/hamstik-cli-x86_64-apple-darwin.tar.gz"
      sha256 "58509db9e343c054a00acaa36653ab680f9efef0eb134f46782b259be8f95c20"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.3/hamstik-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "69c87f6837b6142aedc4b0675e4c4441d61d9136204c43301242ee8129371a6a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/blackboardstudios/hamstik-cli/releases/download/v0.1.3/hamstik-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e2faa2beae86127324732ed6852a98389567c0831276f6321d80be9520ee188"
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
