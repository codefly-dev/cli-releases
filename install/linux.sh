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
FILENAME="codefly-linux-x86_64"
DOWNLOAD_URL="https://github.com/$USER_REPO/releases/download/$TAG/$FILENAME"

echo "Downloading $DOWNLOAD_URL"

# Download the file                                                                                                                                                                                                  
curl -f -L $DOWNLOAD_URL -o $FILENAME -#

# Check if the file was downloaded correctly
if [ $? -eq 0 ]; then

    # Assuming the binary is named 'codefly'
    # Adjust the binary name based on your actual binary name
    BINARY_NAME="codefly"

    # Move the binary to /usr/local/bin
    mv $FILENAME /usr/local/bin/$BINARY_NAME

    # Make the binary executable
    chmod +x /usr/local/bin/$BINARY_NAME

    echo "Installation completed successfully."
else
    echo "File download failed. Please check the download URL."
fi
