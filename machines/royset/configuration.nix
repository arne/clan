{
  imports = [
    # contains your disk format and partitioning configuration.
    ../../modules/disko.nix
    # this file is shared among all machines
    ../../modules/shared.nix
    ../../modules/programs.nix
  ];

  clan.core.networking.targetHost = "root@10.10.10.25";

  # You can get your disk id by running the following command on the installer:
  # Replace <IP> with the IP of the installer printed on the screen or by running the `ip addr` command.
  # ssh root@royset lsblk --output NAME,ID-LINK,FSTYPE,SIZE,MOUNTPOINT
  disko.devices.disk.main.device = "/dev/disk/by-id/nvme-eui.002538b961b196cf";

  clan.core.networking.zerotier.networkId = builtins.readFile ../../vars/per-machine/cube/zerotier/zerotier-network-id/value;
}
