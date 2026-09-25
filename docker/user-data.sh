#!/bin/bash
set -e

dnf install -y docker
systemctl enable --now docker

docker run -d \
  --name three-tier-app \
  --restart unless-stopped \
  -p 8080:80 \
  nginx:alpine
