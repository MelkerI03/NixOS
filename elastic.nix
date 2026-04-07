{ legacy, ... }:
{

  # -------------------------
  # General
  # -------------------------

  networking.firewall.allowedTCPPorts = [
    9292 # Logstash
    9200 # Elasticsearch
    5601 # Kibana
  ];

  # -------------------------
  # Elasticsearch
  # -------------------------

  # Configuration
  services.elasticsearch = {
    enable = true;
    listenAddress = "0.0.0.0";
    port = 9200;
  };

  # -------------------------
  # Elasticsearch
  # -------------------------

  environment.systemPackages = with legacy; [
    kibana
  ];

  # Configuration
  environment.etc."kibana/kibana.yml".text = ''
    server.port: 5601
    server.host: "0.0.0.0"
    elasticsearch.hosts: ["http://localhost:9200"]

    path.data: /var/lib/kibana
  '';

  # Kibana service
  systemd.services.kibana = {
    description = "Kibana";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network.target"
      "elasticsearch.service"
    ];

    serviceConfig = {
      ExecStart = "${legacy.kibana}/bin/kibana";
      Restart = "always";
      User = "kibana";
      Group = "kibana";
      StateDirectory = "kibana";
      Environment = "KBN_PATH_CONF=/etc/kibana";
    };
  };

  # Permissions
  users.users.kibana = {
    isSystemUser = true;
    group = "kibana";
  };

  users.groups.kibana = { };

  # -------------------------
  # LogStash
  # -------------------------

  # Configuration
  services.logstash = {
    enable = true;

    inputConfig = ''
      beats {
        port => 5044
        host => "0.0.0.0"
      }
    '';

    outputConfig = ''
      elasticsearch {
        hosts => ["http://localhost:9200"]
        index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
      }
    '';

  };
}
