This is a NixOS module for setting up NixOS systems to work on Ardana projects. The goal is for this repository to contain all the global configuration needed to work on all projects. This will make setup eaiser and keep people's configurations in sync, leading to better reproducibility.

## Setup
- Add the following code to the `imports` attribute in your `configuration.nix` like so:

```nix
{ imports =
    let
      ardana =
        (builtins.fetchGit
           { url = "git+ssh://git@github.com/ArdanaLabs/nixos-module.git";
             # replace <commit> with an actual commit
             rev = "<commit>";
           }
         )
         + /.;
    in
    [ ardana ];
}
```
- Run `sudo nixos-rebuild switch`

### Use with Flakes
- In your `flake.nix`, add `inputs.ardana.url = "git+ssh://git@github.com/ArdanaLabs/nixos-module.git";`. Then add an `ardana` parameter to your `outputs` function. You'll have access to the module in `outputs` via `ardana.nixosModule`.
- Run `sudo nixos-rebuild switch`

## Options
- `ardana.ci-cache.enable :: bool`
  - default: `false`
  - Whether or not to enable the private CI cache. If you're not authenticated, trying to use this cache will cause your build to fail. Set this to `false` to prevent that. If you've already built your system and now you can't rebuild because it's failing, use `--option substitute false` with `nixos-rebuild` to temporarily disable caching.
