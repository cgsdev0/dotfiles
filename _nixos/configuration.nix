# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
  services.blueman.enable = true;
  services.flatpak.enable = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "orange"; # Define your hostname.
  networking.firewall.enable = false;

  networking = {
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    networkmanager.dns = "none";
  };
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "America/Los_Angeles";
  time.timeZone="America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Configure keymap in X11
  # services.xserver.xkb.options = "caps:escape";

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    wlr.settings = {
      screencast = {
        chooser_type = "dmenu";
        chooser_cmd = "${pkgs.wofi}/bin/wofi --show=dmenu";
      };
    };
  };


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  security.rtkit.enable = true;
  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.pipewire.wireplumber.extraConfig.no-ucm = {
    "monitor.alsa.properties" = {
      "alsa.use-ucm" = false;
    };
  };
  # services.pipewire.wireplumber.extraConfig."bluetooth" = {
  #   "monitor.bluez.properties" = {
  #     "bluez5.codecs" = [ "aptx" ];  # or "aptx_hd" if your headphones support it
  #   };
  # };
  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.groups.plugdev = {};
  users.groups.dialout = {};
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.badcop = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "plugdev" "dialout" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  programs.steam.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    (wrapNeovimUnstable neovim-unwrapped {
      wrapRc = false;
      wrapperArgs = [
        "--prefix" "PATH" ":" "${lib.makeBinPath [ gcc tree-sitter ]}"
      ];
    })
    wget
    wl-clipboard
    ripgrep
    screen
    fd
    mako
    moreutils
    tmux
    discord-ptb
    spotify
    google-chrome
    ghostty
    bluetuith
    ucspi-tcp
    pavucontrol
    pwvucontrol
    crosspipe
    flitter
    wofi
    inotify-tools
    i3status
    direnv
    zoom-us
    grim
    slurp
    wf-recorder
    unzip
    zulip
    gcc
    gnumake
    ffmpeg
    fuzzel
    nodejs
    bc
    xxd
    file
    websocat
    prismlauncher
    jq
    godot
    blender
    wayland-scanner
    s3cmd
    swayr
    wdisplays
    dig
    gum
    figlet
    terminaltexteffects
    viu
    chafa
    freecad
  ];
  services.gnome.gnome-keyring.enable = true;
  # programs.noisetorch.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.udev.extraRules = builtins.readFile ./69-probe-rs.rules;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
