class Unharness < Formula
  desc "A vendor-neutral TUI and CLI runner for AI coding agents"
  homepage "https://github.com/Liquescent-Development/unharness"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.5.0/unharness-aarch64-apple-darwin.tar.xz"
      sha256 "324c89173935ff580857d9bb389ca704fd7332eca6c234d1fa179ed0262322a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.5.0/unharness-x86_64-apple-darwin.tar.xz"
      sha256 "67bfad19ae1dbfe4554e72c13ed6a933982eb0965bdf1394dfc7aa38c0ed3c84"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.5.0/unharness-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cf3557809005ea0d7e2a92f3b230b7281274f6f06659b78e305deadb8d5f3824"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.5.0/unharness-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1b656ba5fdf01ae3a3a1620e0ea154ad25d693cde5810fa38ae6cd7ef55a705c"
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
