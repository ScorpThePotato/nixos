{ pkgs, ...}:

{
  programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    protonup-qt
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];

}
