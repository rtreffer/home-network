resource "grafana_dashboard" "home" {
	config_json = file("home.json")
	overwrite = "true"
}
