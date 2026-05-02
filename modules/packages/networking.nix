{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    inetutils
    netcat
    traceroute
    mtr
    wireguard-tools
  ];
}
