class Unharness < Formula
  desc "A vendor-neutral TUI and CLI runner for AI coding agents"
  homepage "https://github.com/Liquescent-Development/unharness"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.6.0/unharness-aarch64-apple-darwin.tar.xz"
      sha256 "d8286a69d57d4d684e2e77eb8bc3cbf38c352e969e5a014623463c145176769e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.6.0/unharness-x86_64-apple-darwin.tar.xz"
      sha256 "57de7528abd7f52c68bbfa7323879e49cfbb787811506024b1125833957a4d18"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.6.0/unharness-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6f11fd1f8bae78ec99ac9d4cf03dbf6f2fc480a89e137ee499af4fce8620b1c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.6.0/unharness-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e80e4d438e0721904f0133359719571140ec4ff0afdca6f4641657734829d488"
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
