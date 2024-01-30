{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.desktop.kde;
in {
    options.desktop.kde = {

      enable = mkEnableOption "KDE Plasma";

      wayland = mkOption {
          type = types.bool;
          default = false;
          description = "Default to the wayland session for KDE Plasma.";
      };
    };


    config = mkIf cfg.enable (mkMerge [
    {
      services.xserver.desktopManager.plasma5.enable = true;

      programs.partition-manager.enable = true;

      environment.plasma5.excludePackages = with pkgs.libsForQt5; [
        elisa
        gwenview
        okular
        oxygen
        khelpcenter
        plasma-browser-integration
        print-manager
      ];

    }
      (mkIf cfg.wayland {
        services.xserver.displayManager.defaultSession = "plasmawayland";
      })
    ]);
}
