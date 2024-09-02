# Repopack-nix

A flake for making use of [repopack](https://github.com/yamadashy/repopack) more
convenient on nixos.

Will probably make pr to nixpkgs.

## Usage

```sh
# Run without any options
nix run "github:nebunebu/repopack-nix"

# Run with help option
nix run "github:nebunebu/repopack-nix" -- --help

# Run on remote github repository
nix run "github:nebunebu/repopack-nix" -- --remote <owner>/<name>
```
