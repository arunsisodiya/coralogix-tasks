#!/bin/bash -xe

#------------------------------------------------------------------------------#
#                     MONITORING COMPONENTS BOOTSTRAP                          #
#------------------------------------------------------------------------------#
# This script is used to  install the monitoring components in an EC2 instance #
# The script prometheus & node exporter to export the node metrics.            #
#------------------------------------------------------------------------------#

# GLOBAL VARIABLES
NODE_EXPORTER_VERSION="1.8.2"
PROMETHEUS_VERSION="2.53.1"
COROLOGIX_API_KEY="<PRIVATE_KEY>" # Replace with your Corologix API Key
COROLOGIX_API_URL="https://ingress.eu2.coralogix.com/prometheus/v1"

function install_node_exporter() {
    echo "Installing Node Exporter"

    # Download the Node Exporter binary
    cd /tmp || return
    wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
    tar -xvf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz

    # Move the binary to /usr/local/bin
    sudo mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/
    sudo useradd -rs /bin/false node_exporter || true

    # Create the service file
    echo -e "
[Unit]
Description=Node Exporter
After=network.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/node_exporter.service >/dev/null

    # Reload the systemd daemon
    # Start the Node Exporter service
    sudo systemctl daemon-reload
    sudo systemctl start node_exporter
    sudo systemctl enable node_exporter
}

function install_prometheus() {
    echo "Installing Prometheus"

    # Create the Prometheus user
    sudo useradd --no-create-home --shell /bin/false prometheus || true

    # Create the directories
    sudo mkdir /etc/prometheus || true
    sudo mkdir /var/lib/prometheus || true

    # Download the Prometheus binary
    cd /tmp || return
    wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
    tar -xvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

    # Move the binaries to /usr/local/bin
    sudo mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/prometheus /usr/local/bin/
    sudo mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/promtool /usr/local/bin/

    # Change the ownership of the binaries
    sudo chown prometheus:prometheus /usr/local/bin/prometheus
    sudo chown prometheus:prometheus /usr/local/bin/promtool

    # Changing the ownership of the directories
    sudo chown -R prometheus:prometheus /etc/prometheus
    sudo chown -R prometheus:prometheus /var/lib/prometheus

    # Moving the binaries to prometheus directory
    sudo mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/consoles /etc/prometheus
    sudo mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/console_libraries /etc/prometheus
    sudo chown -R prometheus:prometheus /etc/prometheus

    # Create the Prometheus configuration file
    sudo echo -e "global:
      scrape_interval: 15s
      evaluation_interval: 15s

    remote_write:
      - url: ${COROLOGIX_API_URL}
        name: Corologix
        remote_timeout: 60s
        bearer_token: ${COROLOGIX_API_KEY}

    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
        - targets: ['localhost:9090']
      - job_name: 'node_exporter'
        static_configs:
        - targets: ['localhost:9100']
    " >/etc/prometheus/prometheus.yml

    sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

    # Create the service file
    sudo echo -e "[Unit]
    Description=Prometheus
    After=network.target

    [Service]
    User=prometheus
    Group=prometheus
    Type=simple
    ExecStart=/usr/local/bin/prometheus \
        --config.file /etc/prometheus/prometheus.yml \
        --storage.tsdb.path /var/lib/prometheus/ \
        --web.console.templates=/etc/prometheus/consoles \
        --web.console.libraries=/etc/prometheus/console_libraries

    [Install]
    WantedBy=multi-user.target" >/etc/systemd/system/prometheus.service

    # Reload the systemd daemon
    # Start the Prometheus service
    sudo systemctl daemon-reload
    sudo systemctl start prometheus
    sudo systemctl enable prometheus
}

function main() {
    install_node_exporter
    install_prometheus
}

main
