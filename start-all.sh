#!/bin/bash

directories=("info" "share" "media" "network" "prod")

for dir in "${directories[@]}"; do
  cd "$dir"
  docker compose up -d
  cd ..
done

echo "All stacks have been started!" 