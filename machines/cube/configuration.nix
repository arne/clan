_:{
  imports = [
    ../../modules/disko.nix
    ../../modules/shared.nix
    ../../modules/programs.nix
  ];

  boot.supportedFilesystems = [ "zfs" ];

  networking.hostId = "46630107";

  services = {
    zfs = {
      autoScrub.enable = true;
      autoSnapshot.enable = true;
    };
    immich = {
      enable = true;
      host = "0.0.0.0";
      mediaLocation = "/storage/photos";
      openFirewall = true;
    };
    plex = {
      enable = true;
      openFirewall = true;
      group = "users";
    };
  };


  clan.core.networking.targetHost = "root@10.10.10.10";

#  services.immich = {
#    enable = true;
#    host = "0.0.0.0";
#    mediaLocation = "/storage/photos";
#  };


  # You can get your disk id by running the following command on the installer:
  # Replace <IP> with the IP of the installer printed on the screen or by running the `ip addr` command.
  # ssh root@<IP> lsblk --output NAME,ID-LINK,FSTYPE,SIZE,MOUNTPOINT
  disko.devices.disk.main.device = "/dev/disk/by-id/nvme-eui.00000000000000000026b7382faa1195";

  clan.core.networking.zerotier.controller.enable = true;
}
