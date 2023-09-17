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
    hostName = "cadenmiller.dev";
    config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
    https = true;
    configureRedis = true;
  };

  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    enableACME = true;
  };

  # Open some ports
  networking.firewall.allowedTCPPorts = [80 443 25565 25566]; # mc, mc bta, https:mailzor
  networking.firewall.allowedUDPPorts = [25565 25566]; # mc, mc bta
}
