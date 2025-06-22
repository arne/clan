{ pkgs, config, clan-core, ... }:
{
  programs = {
  neovim = {
    enable = true;
    defaultEditor = true;
    # package = unstablePkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
  };
  nix-ld.enable = true;
  fish.enable = true;
  tmux = {
    enable = true;
    clock24 = true;
  };
  mosh = {
    enable = true;
  };
};

environment.systemPackages =
  with pkgs;
  [
    bat
    beszel
    bottom
    clang
    corepack_20
    comma
    docker-compose
    emacs
    eternal-terminal
    eza
    fm-go
    fzf
    gcc
    gh
    ghostty
    git
    htop
    iamb
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    lazygit
    nixfmt-rfc-style
    nix-your-shell
    nodejs_20
    python3
    ripgrep
    ruby
    termscp
    # thefuck
    yt-dlp
    wget
    zellij
    zoxide
    # nodePackages.wrangler
  ];
}
