# Liquescent Development Homebrew tap

Homebrew casks for software published by Liquescent Development LLC.

## Install

```sh
brew tap liquescent-development/tap
brew trust liquescent-development/tap
brew install --cask gascan
```

Homebrew 6 refuses to load casks from a third-party tap until you trust it, so
the `brew trust` step is required and not merely advisory. Without it,
`brew install` stops with `Refusing to load cask ... from untrusted tap`. To
trust only this one cask instead of the whole tap:

```sh
brew trust --cask liquescent-development/tap/gascan
```

## Casks

### `gascan` — [Gas Can](https://github.com/Liquescent-Development/gascan)

A secure local sandbox for agentic coding.

Gas Can targets Apple-silicon Macs running macOS 26 or newer. It requires Apple
`container` 1.1.0 and its running service, which Gas Can neither installs nor
redistributes. Verify the host with:

```sh
gascan doctor --json
```

The cask installs a Developer ID signed, notarized, and stapled package, so
installation raises no Gatekeeper prompt. Homebrew verifies the release
checksum before installing.

To remove it:

```sh
brew uninstall --cask gascan
```

Uninstalling removes the package-owned binaries, documentation, and the package
receipt. It deliberately preserves sandboxes, Apple volumes, caches, and
controller state. To remove those too, use Gas Can's own uninstaller with
`--remove-data` before uninstalling the cask.
