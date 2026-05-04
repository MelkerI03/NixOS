{ ... }:
{
  # För labb-miljö
  # NOTE: DO NOT ADD TO GIT REPO
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [
        "10.20.0.12/32"
      ];
      dns = [ "10.10.0.1" ];
      privateKey = "mImvIZxb3jnD7B0B8yg//cbMt+wlkgn+ZaVDb6+SwGU=";
      peers = [
        {
          publicKey = "wYkgixjIwdSNz6ua4LYeQUsF3mtAnJA5AY8LsA9WS0A=";
          allowedIPs = [
            "10.10.0.0/16"
          ];
          endpoint = "192.168.3.30:51820";
        }
      ];
    };
  };
}
