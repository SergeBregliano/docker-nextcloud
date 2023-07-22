#!/bin/bash

# Use of docker-compose or docker compose
DOCKERCOMPOSE=docker-compose
if !(type docker-compose) ; then
    DOCKERCOMPOSE='docker compose'
    echo "Will use docker compose to replace docker-compose command."
fi

# Update the stack
echo 'Updating configuration files'
echo '============================'
git pull https://gitlab.com/Slt/docker-nextcloud.git master
echo ''

# Download the new images version
echo 'Update and build new images'
echo '==========================='
docker pull nextcloud:fpm
docker pull nginx
$DOCKERCOMPOSE pull
$DOCKERCOMPOSE build
echo ''

# Stop last stack, delete it, and start the new one
echo 'Shutting down servers'
echo '====================='
$DOCKERCOMPOSE down
echo ''

echo 'Deleting images'
echo '==============='
$DOCKERCOMPOSE rm -f
echo ''

echo 'Start new images'
echo '================'
$DOCKERCOMPOSE up -d --remove-orphans
echo ''

echo 'Your stack has been correctly updated.'
echo ''