{
  nixpkgs.hostPlatform = "x86_64-linux";

  boot.loader.systemd-boot.enable = true;

  fileSystems."/" = {
    device = "/dev/vda";
    fsType = "ext4";
  };
}