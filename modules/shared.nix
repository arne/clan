{ pkgs, config, clan-core, self, ... }:
{
  imports = [
    # Enables the OpenSSH server for remote access
    clan-core.clanModules.sshd
    # Set a root password
    clan-core.clanModules.root-password
    clan-core.clanModules.user-password
    clan-core.clanModules.state-version

    self.inputs.nix-index-database.nixosModules.nix-index
  ];

  nixpkgs.config.allowUnfree = true;

  # generate a random password for our user below
  # can be read using `clan secrets get <machine-name>-user-password` command

  users.users.user.name = "arne";
  clan.user-password.user = "user";

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJkHOi39HCigHCOneTKIiY+C809n6d3sNHd3hoy2Uq21 Warden"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGJMA+ii3/JAZqgBQCVI5xFOgM6gVsCjuP8PaaXr1bcJ"
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHb1GcfjCCMlzVsZw5Zku7UvbF3QrFPbP+kxFDU4a+H/9p2HalYD43ZkaJQphQMYqC1MIQd4Cjmg1RTbUTneC+M= apad@arnefismen.com"
  ];

  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
    ];
    uid = 1000;
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;
  };

  security.sudo = {
    extraRules = [
      {
        users = [ "privileged_user" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
    wheelNeedsPassword = false;
  };

  programs.nix-index-database.comma.enable = true;

  services = {
    avahi.enable = true;
    tailscale.enable = true;
  };

  systemd.services.beszelagent = {
    enable = true;
    description = "Beszel agent";
    unitConfig = {
      Type = "simple";
    };
    serviceConfig = {
      Restart = "always";
      User = "root";
      ExecStart = "${pkgs.beszel}/bin/beszel-agent -key 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILnr1kpK27OFGtqrs7hPjnxY4WQiz1V1XmJQkM4U3RM7'";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
