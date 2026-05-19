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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
export FORGIT_FZF_DEFAULT_OPTS=" --border --cycle --ansi --reverse --height '80%' --preview-window right:66%"
export FZF_BASE=$(fzf-share)
source "$(fzf-share)/completion.zsh"
source "$(fzf-share)/key-bindings.zsh"
    '';
    shellAliases = {
      ll = "ls -l";
      gst = "git status";
      update = "sudo nixos-rebuild switch --flake /home/badcop/dotfiles/_nixos#orange --show-trace";
    };
    history.size = 1000000;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "sindresorhus/pure"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "kytta/ohmyzsh-key-bindings"; }
        { name = "wfxr/forgit"; }
        { name = "junegunn/fzf"; }
      ];
    };
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [
    #     "zsh-autosuggestions"
    #     "zsh-syntax-highlighting"
    #     "zsh-history-substring-search"
    #   ];
    #   theme = "pure";
    # };
  };
  home.stateVersion = "25.11"; # Match your NixOS version
}
