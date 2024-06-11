#!/bin/bash
# Copyright (c) Swarm Library Maintainers.
# SPDX-License-Identifier: MIT

set -e

# If the user is trying to run Prometheus directly with some arguments, then
# pass them to Prometheus.
if [ "${1:0:1}" = '-' ]; then
    set -- node_exporter "$@"
fi

# If the user is trying to run Prometheus directly with out any arguments, then
# pass the configuration file as the first argument.
if [ "$1" = "" ]; then
    set -- node_exporter \
      --path.rootfs="/rootfs" \
      --collector.filesystem.ignored-mount-points="^/(sys|proc|dev|host|etc)($$|/)" \
      --collector.textfile.directory="/etc/node-exporter/" \
      --no-collector.ipvs
fi

echo "==> Starting Node exporter..."
set -x
exec "$@"
