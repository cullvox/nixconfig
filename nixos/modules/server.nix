{pkgs, ...}: {
  home-manager.users.cullvox = {pkgs, ...}: {
    home.packages = with pkgs; [
      nodejs-slim
      openjdk17-bootstrap
      openjdk8-bootstrap
    ];
  };
}
