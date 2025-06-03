_:{
  imports = [
    # contains your disk format and partitioning configuration.
    ../../modules/disko.nix
    # this file is shared among all machines
    ../../modules/shared.nix
    ../../modules/programs.nix
  ];

  clan.core.networking.targetHost = "root@10.10.10.10";

  # You can get your disk id by running the following command on the installer:
  # Replace <IP> with the IP of the installer printed on the screen or by running the `ip addr` command.
  # ssh root@<IP> lsblk --output NAME,ID-LINK,FSTYPE,SIZE,MOUNTPOINT
  disko.devices.disk.main.device = "/dev/disk/by-id/nvme-eui.00000000000000000026b7382faa1195";

  clan.core.networking.zerotier.controller.enable = true;
}
