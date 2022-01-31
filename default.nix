with builtins;
{ config, pkgs, lib, ... }:
  let l = lib; p = pkgs; t = l.types; in
  { options.ardana.caches =
      let
        make-cache-option = default: name:
          l.mkOption
            { type = t.bool;
              inherit default;
              description = "Whether or not to enable the ${name}";
            };
      in
      { cachix = make-cache-option false "private chachix cache";
        ci = make-cache-option false "private CI cache";
        iohk = make-cache-option true "IOHK caches";
      };

    config =
      { nix =
          let
            create = caches: keys: { inherit caches keys; };
            empty = create [] [];

            cache-info =
              let inherit (config.ardana) caches; in
              { cachix =
                  if caches.cachix then
                    create
                      [ "https://private-ardanalabs.cachix.org" ]
                      [ "private-ardanalabs.cachix.org-1:BukERsr5ezLsqNT1T7zlS7i1+5YHsuxNTdvcgaI7I6Q=" ]
                  else
                    empty;

                ci =
                  if caches.ci then
                    create
                      [ "ssh://nix-ssh@ci.ardana.platonic.systems" ]
                      [ "ci.ardana.platonic.systems:yByqhxfJ9KIUOyiCe3FYhV7GMysJSA3i5JRvgPuySsI=" ]
                  else
                    empty;

                iohk =
                  if caches.iohk then
                    create
                      [ "https://iohk.cachix.org" "https://hydra.iohk.io" ]
                      [ "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
                        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
                      ]
                  else
                    empty;
              };
          in
          { binaryCaches =
              l.pipe cache-info
                [ attrValues
                  (map (a: a.caches))
                  concatLists
                ];

            binaryCachePublicKeys =
              l.pipe cache-info
                [ attrValues
                  (map (a: a.keys))
                  concatLists
                ];
          };

          services.postgresql =
            { enable = true;
              package = p.postgresql_13;
              port = 5432;

              # https://www.postgresql.org/docs/current/auth-pg-hba-conf.html
              authentication = "local all all trust";
            };
      };
  }
