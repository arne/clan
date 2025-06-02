{
  inputs  = {
    clan-core.url = "https://git.clan.lol/clan/clan-core/archive/main.tar.gz";
    nixpkgs.follows = "clan-core/nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, clan-core, nix-index-database, ... }:
    let
      # Usage see: https://docs.clan.lol
      clan = clan-core.clanLib.buildClan {
        inherit self;
        meta.name = "fismen";

        machines = {
          # You can also specify additional machines here.
          # somemachine = {
          #  imports = [ ./some-machine/configuration.nix ];
          # }
        };
        secrets.age.plugins = [
          "age-plugin-yubikey"
          "age-plugin-fido2-hmac"
        ];
      };
    in
    {
      inherit (clan) nixosConfigurations clanInternals;
      # Add the Clan cli tool to the dev shell.
      # Use "nix develop" to enter the dev shell.
      devShells =
        clan-core.inputs.nixpkgs.lib.genAttrs
          [
            "x86_64-linux"
            "aarch64-linux"
            "aarch64-darwin"
            "x86_64-darwin"
          ]
          (system: {
            default = clan-core.inputs.nixpkgs.legacyPackages.${system}.mkShell {
              packages = [ clan-core.packages.${system}.clan-cli ];
            };
          });
    };
}
