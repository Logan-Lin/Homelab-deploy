#!/bin/bash

directories=("network" "info" "share" "media" "prod")

for dir in "${directories[@]}"; do
  cd "$dir"
  docker compose up -d
  cd ..
done

echo "All stacks have been started!" 