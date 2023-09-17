{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    # hostName = "cadenmiller.dev";
    hostName = "192.168.1.32";
    home = "/mnt/nextcloud/home";
    datadir = "/mnt/nextcloud/data";
    config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
    # https = true;
    configureRedis = true;
  };

  #services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
  #  forceSSL = true;
  #  enableACME = true;
  #};

  #security.acme.acceptTerms = true;

  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [pkgs.cifs-utils];
  fileSystems."/mnt/nextcloud" = {
    device = "//192.168.1.85/Cloud";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=1.0,mfsymlinks";
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=995,gid=994"];
  };

  # Open some ports
  networking.firewall.allowedTCPPorts = [80 443 25565 25566]; # mc, mc bta, https:mailzor
  networking.firewall.allowedUDPPorts = [25565 25566]; # mc, mc bta
}
