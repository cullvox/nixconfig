{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs-slim
    openjdk17-bootstrap
  ];
}
