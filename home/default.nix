{pkgs, ...}: {
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    unzip
    git
    gcc
    cmake
    nitch
    rofi
  ];
  programs = {
    bash.enable = true;
    direnv.enable = true;

    helix = {
      enable = true;
      settings = {
        theme = "monokai_pro_spectrum";
      };
      languages = {
        language = [
          {
            name = "nix";
            formatter.command = "${pkgs.alejandra}/bin/alejandra";
            auto-format = true;
          }
        ];
      };
    };
  };
}
