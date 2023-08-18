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

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;

  # services.xserver.desktopManager.plasma5.enable = true;

  # Enable flatpaks
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  services.flatpak.enable = true;

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
      ];
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable NVIDIA GPU
  # NVIDIA drivers are unfree.

  hardware.opengl.enable = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.opengl.driSupport32Bit = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  programs.dconf.enable = true; # GNOME's registry

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  #environment.sessionVariables = {
  #  QT_QPA_PLATFORMTHEME = "qt5ct";
  #};

  environment.variables.QT_QTA_PLATFORMTHEME = "qt5ct";

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.cullvox = {pkgs, ...}: {
    imports = [
      ../home
    ];

    home.packages = with pkgs; [
      firefox
      kate
      helix
      alacritty
      pavucontrol
      easyeffects
      yuzu-mainline
      winetricks
      prismlauncher
      lunar-client

      qt5ct
      breeze-icons
      libsForQt5.elisa
      libsForQt5.dolphin
      libsForQt5.spectacle

      #(discord.override { withOpenASAR = true; })
      discord
      spotify
      lutris
      vscode.fhs
      (pkgs.unityhub.override {
        extraPkgs = pkgs:
          with pkgs; [
            xdg-utils
          ];
      })

      #thunderbird
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cullvox = {
    isNormalUser = true;
    description = "Caden Miller";
    extraGroups = ["networkmanager" "wheel"];
  };

  services.gnome.gnome-keyring.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # open ports in the firewall for steam remote play
    # dedicatedServer.openFirewall = true; # open ports in the firewall for source dedicated server
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    helix
    clang-tools
  ];

  networking.firewall.allowedTCPPorts = [3074]; # plutonium bo2
  networking.firewall.allowedUDPPorts = [3074];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
