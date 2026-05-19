{ config, pkgs, ... }: {
  home.username = "badcop";
  home.homeDirectory = "/home/badcop";
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 32;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  programs.home-manager.enable = true;
  home.packages = [ pkgs.htop pkgs.git pkgs.fzf ];

  home.stateVersion = "25.11"; # Match your NixOS version
}
