# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  # Bootloader.
  boot.loader.grub = let
    minegrub = pkgs.fetchFromGitHub {
      owner = "Lxtharia";
      repo = "minegrub-theme";
      rev = "1e31c7feb22eadbe4f80f6f8c2d63681b337676f";
      hash = "sha256-zP+6xqlupDzYPe+24348uAjnD7nxggmC+tfUJkyf+hk=";
    };
  in {
    enable = true;
    device = "nodev";
    efiSupport = true;
    # useOSProber = true;
    theme = minegrub;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  nix.settings.experimental-features = "nix-command flakes";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set my time zone.
  time.timeZone = "America/New_York";

  # Set my internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Add homemanager to manage my home.
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.cullvox = {pkgs, ...}: {
    imports = [
      ../home
    ];
  };

  # Add my favorite fonts.
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
  ];

  # My user account.
  users.users.cullvox = {
    isNormalUser = true;
    description = "Caden Miller";
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$6$iekUUVuQpAjjVD6u$rRp9o7owwh5DZ0DPoCU7iIeeJrFZhSlDk/3r/kvlWNTA9CRshiSWfU6NFKd.N4vzPJqak47u2fER7q6.rXja/.";
  };

  # GNOME's registry
  programs.dconf.enable = true;

  # Enable the keyring.
  services.gnome.gnome-keyring.enable = true;

  # Allow unfree packages for drivers, discord and the like.
  nixpkgs.config.allowUnfree = true;

  # Default applications that come with every host.
  environment.systemPackages = with pkgs; [
    helix
    clang-tools
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
