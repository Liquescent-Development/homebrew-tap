cask "gascan" do
  version "0.1.4"
  sha256 "dd2ed03b9e7eeb82c2ff7c2a8735d52c9b683afb1e0ad419263e26552ba50ebd"

  url "https://github.com/Liquescent-Development/gascan/releases/download/v#{version}/gascan-#{version}-macos-arm64.pkg"
  name "Gas Can"
  desc "Secure local sandbox for agentic coding"
  homepage "https://github.com/Liquescent-Development/gascan"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  pkg "gascan-#{version}-macos-arm64.pkg"

  uninstall pkgutil: "dev.gascan.pkg",
            delete:  [
              "/usr/local/bin/gascan",
              "/usr/local/bin/gascan-apple-attach",
              "/usr/local/bin/gascand",
              "/usr/local/share/gascan",
              "/usr/local/share/gascan/build-manifest.json",
              "/usr/local/share/gascan/default-gascan.toml",
              "/usr/local/share/gascan/LICENSE",
            ]

  caveats <<~EOS
    Gas Can requires Apple container 1.1.0 and its running service. Gas Can does
    not install or redistribute it.

    Verify the host with:
      gascan doctor --json
  EOS
end
