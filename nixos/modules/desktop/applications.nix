{pkgs, ...}: {
  home-manager.users.cullvox = {pkgs, ...}: {
    home.packages = with pkgs; [
      rofi
      firefox
      kate
      helix
      alacritty
      pavucontrol
      easyeffects
      yuzu-mainline
      winetricks
      prismlauncher
      blockbench-electron
      appimage-run
      polybar
      libreoffice
      lite-xl
      godot_4

      qt5ct
      breeze-icons
      libsForQt5.elisa
      libsForQt5.dolphin
      libsForQt5.spectacle

      #(discord.override { withOpenASAR = true; })
      lunar-client
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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # open ports in the firewall for steam remote play
    # dedicatedServer.openFirewall = true; # open ports in the firewall for source dedicated server
  };
}
