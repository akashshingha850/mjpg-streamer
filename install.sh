
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update package list and install dependencies
sudo apt update
sudo apt install -y git cmake build-essential libjpeg8

# Clone the repository
git clone https://github.com/akashshingha850/mjpg-streamer
cd mjpg-streamer

# Build the project
make

# Install the binaries
sudo make install

# Clean up
#cd ../..
#rm -rf mjpg-streamer

echo "mjpg-streamer installation completed successfully."

chmod +x start.sh

# Run start.sh
#./start.sh
#echo "mjpg-streamer started successfully."

# Create systemd service file
sudo bash -c 'cat > /etc/systemd/system/mjpg-streamer.service <<EOF
[Unit]
Description=mjpg-streamer service
After=network.target


[Service]
ExecStart=/home/jetson/mjpg-streamer/start.sh
WorkingDirectory=/home/jetson/mjpg-streamer/
Restart=always
User=jetson


[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd, enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable mjpg-streamer.service
sudo systemctl start mjpg-streamer.service

# Check the status of the service
sudo systemctl status mjpg-streamer.service

echo "mjpg-streamer service installed and started successfully."
