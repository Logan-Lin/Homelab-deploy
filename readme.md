There are two ways to build the proxy network:

1. All services communicate through the `proxy` network. This requires setup of this network with cli: `docker network create proxy --driver bridge`.
2. Each web service gets its dedicated IP address through the `br0` network through the `macvlan` driver.

I am using a mix of both. You can actually attach a container to both types of networks at the same time.


# Sevice stacks

## Network stack

Series of services for network management.

Contains:
- proxy: Nginx proxy manager for reverse proxy
- pihole: DNS sinkhole for ad blocking
- sync: sync pihole configurations across multiple hosts
- watchtower: auto update services

## Info stack

A self-contained collection of services for information aggregation and reading.

Contains:
- rss: (miniflux) RSS aggregator and reader
- db: (postgresql) database for miniflux
- hub: (RSSHub) RSS feed generator for websites without native RSS feeds
- link: (linkding) bookmark management and snapshot

The "hub" is only accessible within the inner network among these services. In minuflux, use `http://hub:1200` as the base URL of the RSSHub.

## Media stack

A series of services for media management and streaming.

Contains:
- Plex: media server for movies, tv, music, etc.
- AudioBookshelf: media server for audiobooks and podcasts
- Arr stacks:
    - Sonarr: tv show manager
    - Radarr: movie manager
    - Lidarr: music manager
    - Bazarr: subtitle manager
- qBittorrent: torrent client
- immich: home photo and video backup
- immich-db: database for immich, a special postgres version with vector extension
- immich-redis: redis for immich

Arr stacks can connect with the torrent client through the internal network. Use `http://qbit:8080` as the web UI URL of qBittorrent.

## Share stack

A collection of services for file sharing and backup.

Contains:
- cloud: (nextcloud) cloud storage
- cloud-db: (mariadb) database for nextcloud
- webdav: (apachewebdav) webdav server
- syncthing: p2p file synchronization
- borg: (borgmatic) snapshot backup tool

During initial setup of nextcloud, select "mysql/mariadb" and use `http://db:3306` as the database URL.

## Productivity stack

A collection of services for productivity.

Contains:
- paperless: scanned document management
- paperless-redis: redis for paperless