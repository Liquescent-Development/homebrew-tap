class Unharness < Formula
  desc "A vendor-neutral TUI and CLI runner for AI coding agents"
  homepage "https://github.com/Liquescent-Development/unharness"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.2.0/unharness-aarch64-apple-darwin.tar.xz"
      sha256 "c959dfd8e23f5164c9585cbc4ea76787b2594308cd2d7c35e8367413b253b2f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.2.0/unharness-x86_64-apple-darwin.tar.xz"
      sha256 "c0bb330d73a56907f84b92e7b7653223c72751cb7016191cac8c144cbc0c9445"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.2.0/unharness-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6d0b2710765aa0f01d3341ddc226d3c426c6476e55867f00ccee082b724d4de7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Liquescent-Development/unharness/releases/download/v0.2.0/unharness-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c6b8b898eaedf7b928f791865d8d3c8a1eb0bdb1cdc1a544820e520333ea0810"
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
