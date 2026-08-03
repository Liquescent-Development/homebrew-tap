cask "gascan" do
  version "0.1.18"
  sha256 "5f351aefb1c1458911837494af46facfae45b0a9b308795f46da1890528d51c2"

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
