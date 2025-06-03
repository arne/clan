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
    clang
    corepack_20
    comma
    docker-compose
    emacs
    eternal-terminal
    eza
    fzf
    gcc
    gh
    ghostty
    git
    htop
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    lazygit
    nixfmt-rfc-style
    nodejs_20
    python3
    ripgrep
    ruby
    # thefuck
    yt-dlp
    wget
    zellij
    zoxide
    # nodePackages.wrangler
  ];
}
