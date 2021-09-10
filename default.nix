{ config, lib, ... }:
  let l = lib; t = l.types; in
  { # if you're not authenticated, trying to use this cache will cause your build to fail
    options.ardana.ci-cache.enable =
      l.mkOption
        { type = t.bool;
          default = true;
          description = "Whether or not to enable the private CI cache";
        };

    config =
      { nix =
          { binaryCaches =
              [ "https://iohk.cachix.org"
                "https://hydra.iohk.io"
              ]
              ++ (if config.ardana.ci-cache.enable then
                    [ "ssh://nix-ssh@ci.ardana.platonic.systems" ]
                  else
                    []
                 );

            binaryCachePublicKeys =
              [ "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
                "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
                "ci.ardana.platonic.systems:yByqhxfJ9KIUOyiCe3FYhV7GMysJSA3i5JRvgPuySsI="
              ];
          };
      };
  }
