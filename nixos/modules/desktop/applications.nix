{pkgs, ...}: {
  home-manager.users.cullvox = {pkgs, ...}: {
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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # open ports in the firewall for steam remote play
    # dedicatedServer.openFirewall = true; # open ports in the firewall for source dedicated server
  };
}
