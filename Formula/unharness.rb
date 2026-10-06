class Unharness < Formula
  desc "A vendor-neutral TUI and CLI runner for AI coding agents"
  homepage "https://github.com/Liquescent-Development/unharness"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.4.0/unharness-aarch64-apple-darwin.tar.xz"
      sha256 "c45817810fdf20e2cbea9704627727129b4cfcb2aed16a7b3d44da132ae51644"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.4.0/unharness-x86_64-apple-darwin.tar.xz"
      sha256 "1e385d7bbf64048a275c1847adfacc9877bfe212f7b590edc974ab0149369323"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.4.0/unharness-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cd4cfec920de8e9ce7002779540aae86c63e76ae44445371e9064603b7fab062"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.4.0/unharness-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a2794fc24045ee3520122283f331587b612339accc1145deea78daa9c4f755d1"
    end
  end
  license "AGPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "unharness"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "unharness"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "unharness"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "unharness"
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
