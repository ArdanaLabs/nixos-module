{ nix =
    { binaryCaches =
        [ "https://iohk.cachix.org"
          "https://hydra.iohk.io"
          "ssh://nix-ssh@ci.ardana.platonic.systems"
        ];

      binaryCachePublicKeys =
        [ "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
          "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
          "ci.ardana.platonic.systems:yByqhxfJ9KIUOyiCe3FYhV7GMysJSA3i5JRvgPuySsI="
        ];
    };
}
