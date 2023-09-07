{config, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [25565 443]; # minecraft, https:mailzor
  networking.firewall.allowedUDPPorts = [25565]; # minecraft
}
