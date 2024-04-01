#!/bin/bash
 
# GitHub user/repo
USER_REPO="codefly-dev/cli-releases"
 
# Fetch the latest release data from GitHub API
URL="https://github.com/$USER_REPO/releases/latest"
 
# Use curl to fetch the latest release page and grep to parse the tag
TAG=$(curl -sL $URL | grep -oP 'href="/'$USER_REPO'/releases/tag/\K[^"]+' | head -1)
 
# Construct the download URL
# Assuming the naming convention is 'codefly_<tag>_linux-x86_64-bit.tar.gz'
# Adjust the naming convention based on your actual release asset names
FILENAME="codefly_linux_64-bit.tar.gz"
DOWNLOAD_URL="https://github.com/$USER_REPO/releases/download/$TAG/$FILENAME"
 
# Download the file                                                                                                                                                                                                  
curl -L $DOWNLOAD_URL -o $FILENAME

# Untar the file
tar -xzf $FILENAME

# Assuming the binary is named 'codefly'
# Adjust the binary name based on your actual binary name
BINARY_NAME="codefly"

# Move the binary to /usr/local/bin
sudo mv $BINARY_NAME /usr/local/bin

# Make the binary executable
sudo chmod +x /usr/local/bin/$BINARY_NAME

# Clean up the downloaded tar file
rm $FILENAME

echo "Installation completed successfully."

