{config, pkgs, ...}: { 
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    unzip
    neovim
    kitty
    tmux
    zsh
    pciutils
    git
    steam
    neofetch
    wineWowPackages.stable
    winetricks
    btop
    trashy
    bat
    lua
    wofi
    dolphin
    swww
    spotify
  ];
}
