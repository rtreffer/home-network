terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.19.0"
    }
  }
}

provider "grafana" {
  url  = "http://prometheus.home.measite.de"
  auth = ""
}


resource "grafana_data_source" "prometheus" {
  type = "prometheus"
  name = "default"
  url  = "http://prometheus.home.measite.de:9090"
  is_default = "true"

  json_data {
    http_method     = "POST"
  }
}
