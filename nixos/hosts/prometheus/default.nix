{config, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.modesetting.enable = true; # Enables a special mode setting for wayland. (if used)
}
