class Unharness < Formula
  desc "A vendor-neutral TUI and CLI runner for AI coding agents"
  homepage "https://github.com/Liquescent-Development/unharness"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.3.0/unharness-aarch64-apple-darwin.tar.xz"
      sha256 "085f0969d54a8f3235ab7d03c6782067c0e0c75650186635620f12507ce290c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.3.0/unharness-x86_64-apple-darwin.tar.xz"
      sha256 "5f6e0c26a7d23198b63895a40d573efbb3540a950d78125246ffa73765ee5d0e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.3.0/unharness-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "232e3b1b223d7b37ce6f88d5bbedde2051948be76ee19e8e3bcf1138703184fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.3.0/unharness-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "985f1c7fcd0ff53373f7d423bcdf610a2996cb0bb2e980d5906ab290df9d9bf0"
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
