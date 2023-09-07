{config, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [25565 25566 443]; # mc, mc bta, https:mailzor
  networking.firewall.allowedUDPPorts = [25565 25566]; # mc, mc bta
}
