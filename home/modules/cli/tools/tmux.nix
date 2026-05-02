{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "b";
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      sensible
      yank
      vim-tmux-navigator
      tmux-sessionx
      power-theme
      tmux-thumbs
      yank
    ];
    extraConfig = ''
      set -g mouse on
      set -g repeat-time 300
      set-option -g set-clipboard on

      # Copy util
      set -g @thumbs-command 'echo -n {} | waycopy'

      # Session restore
      set -g @sessionx_auto_restore 'on'
      set -g @sessionx_dir '~/.tmux/sessions'
      set -g @sessionx_autosave_interval '10'

      # Enable default pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind -n M-h resize-pane -L 2
      bind -n M-j resize-pane -D 2
      bind -n M-k resize-pane -U 2
      bind -n M-l resize-pane -R 2

      bind % split-window -h -c "#{pane_current_path}"  # Vertical split
      bind '"' split-window -v -c "#{pane_current_path}"  # Horizontal split
    '';
  };
}
