#!/bin/bash

# GitHub user/repo
USER_REPO="codefly-dev/cli-releases"

# Fetch the latest release data from GitHub API
URL="https://github.com/$USER_REPO/releases/latest"

# Use curl to fetch the latest release page and grep to parse the tag
TAG=$(curl -sL $URL | grep -oP 'href="/'$USER_REPO'/releases/tag/\K[^"]+' | head -1)

# Construct the download URL
# Assuming the naming convention is 'codefly_<tag>_Linux_64-bit.tar.gz'
# Adjust the naming convention based on your actual release asset names
FILENAME="codefly_${TAG}_Linux_64-bit.tar.gz"
DOWNLOAD_URL="https://github.com/$USER_REPO/releases/download/$TAG/$FILENAME"

# Download the file
curl -L $DOWNLOAD_URL -o $FILENAME

echo "Downloaded $FILENAME"
