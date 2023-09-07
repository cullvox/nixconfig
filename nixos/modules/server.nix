{pkgs, ...}: {
  home.file."jdks/openjdk17".source = openjdk17-bootstrap;
  home.file."jdks/openjdk8".source = openjdk8-bootstrap;

  home-manager.users.cullvox = {pkgs, ...}: {
    home.packages = with pkgs; [
      nodejs_18
      jdk17
      jdk8
      screen
    ];
  };
}
