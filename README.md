This is a NixOS module for use by those working on the Ardana projects.

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
