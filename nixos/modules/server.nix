{pkgs, ...}: {
  home-manager.users.cullvox = {pkgs, ...}: {
    home.packages = with pkgs; [
      nodejs_18
      jdk17
      jdk8
      screen
    ];
  };
}
