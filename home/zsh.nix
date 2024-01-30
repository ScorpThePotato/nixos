{ pkgs, lib, ... }:

{
#########################################################################
# FONT CONFIGURATION 

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    meslo-lgs-nf # patched for p10k
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) #For neovide
  ];

#########################################################################

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    initExtraBeforeCompInit = ''
    zstyle ':completion:*' prompt 'Errors: %e'
    zstyle :compinstall filename '/home/scorp/.zshrc'
    zstyle ':completion::complete:*' gain-privileges 1'';
    completionInit = "autoload -U compinit && compinit";
    enableAutosuggestions = true;
    enableVteIntegration = true;


    syntaxHighlighting = {
        enable = true;
        highlighters = [ "main" "brackets" "root" ]; # cursor to change cursor color using styles
        styles = { 
          alias = "fg=214,bold";
          global-alias = "fg=214,bold";
          command = "fg=4,bold";
          builtin = "fg=4,bold";
          commandseparator = "fg=5";
          precommand = "fg=201,bold";
        };
      };


    autocd = true;
    dotDir = ".config/zsh"; # Relative to $HOME


    history = {
      path = "$HOME/.config/zsh/history";
      save = 10000;
      size = 10000;
      share = true;
    };


    localVariables = {}; # e.g: {  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS = [    "dir"    "vcs"  ];}
    #sessionVariables = {};


    initExtraFirst = "source $HOME/.config/zsh/.p10k.zsh";
    initExtra = "";


    loginExtra = "";
    logoutExtra = "";
    profileExtra = "export VISUAL=nvim";


    shellAliases = {
        ls = "ls --color=auto";
        la = "ls --color=auto -a";
        ll = "ls --color=auto -la";
        ".." = "cd ..";
      };
    shellGlobalAliases = {
        pls = "sudo";
        ip = "ip -color=auto";
        grep = "grep --color=auto";
      };

    prezto = {
        enable = true;
        color = true;
        editor.keymap = "emacs";
        editor.dotExpansion = true;
        extraConfig = "zstyle :prezto:module:prompt theme powerlevel10k";
        utility.safeOps = true;
      };
  };
}
