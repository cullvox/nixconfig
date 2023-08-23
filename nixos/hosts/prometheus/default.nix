{config, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.modesetting.enable = true; # Enables a special mode setting for wayland. (if used)

  networking.firewall.allowedTCPPorts = [3074]; # plutonium bo2
  networking.firewall.allowedUDPPorts = [3074];

  # Enable flatpaks for some packages.
  services.flatpak.enable = true;
}
