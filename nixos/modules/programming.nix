{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    cmake
    vscode.fhs
  ];
}
