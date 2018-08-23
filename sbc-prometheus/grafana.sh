#!/bin/bash

set -euo pipefail

apt-get install -y fontconfig-config fonts-dejavu-core libfontconfig1 libfreetype6 libpng16-16
wget -O /tmp/grafana.deb https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_5.2.1_arm64.deb
dpkg -i /tmp/grafana.deb
rm /tmp/grafana.deb

cat > /etc/grafana/grafana.ini << _GRAFANA_
[analytics]
reporting_enabled=false
check_for_updates=false
[security]
admin_user=admin
admin_password=admin
[users]
allow_sign_up=false
allow_org_create=false
auto_assign_org=true
auto_assign_org_role=Admin
[auth]
disable_login_form=true
disable_signout_menu=true
[auth.anonymous]
enabled=true
org_role=Admin
_GRAFANA_

systemctl daemon-reload
systemctl enable grafana-server
systemctl restart grafana-server

chmod 0770 /etc/grafana/provisioning/datasources/

cd /var/lib/grafana/
sudo -Hu grafana grafana-cli plugins install grafana-piechart-panel

