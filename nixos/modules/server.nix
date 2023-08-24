{pkgs, ...}: {
  home-manager.users.cullvox = {pkgs, ...}: {
    home.packages = with pkgs; [
      nodejs_18
      openjdk17-bootstrap
      screen
    ];
  };
}
