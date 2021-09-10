This is a NixOS module for setting up systems to work on Ardana projects. The goal is to have all the global configuration needed to work on all projects set up in this repository.

To import the flake, use the URL `"git+ssh://git@github.com/ArdanaLabs/nixos-module.git"`.

To import without using flakes, add it to `imports` in your `configuration.nix` like so:

```nix
{ imports =
    [ ((builtins.fetchGit
          { url = "git+ssh://git@github.com/ArdanaLabs/nixos-module.git";
            rev = "<commit>";
          }
       )
       + /.
      )
    ]
}
```
