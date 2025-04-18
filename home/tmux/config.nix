{ pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    shortcut = "b";
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      sensible
      yank
      catppuccin
      vim-tmux-navigator
    ];
    extraConfig = ''
      set -g mouse on
      # Enable default pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      bind % split-window -h -c "#{pane_current_path}"  # Vertical split
      bind '"' split-window -v -c "#{pane_current_path}"  # Horizontal split
    '';
  };
}
