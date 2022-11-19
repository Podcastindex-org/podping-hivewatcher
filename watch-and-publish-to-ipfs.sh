#!/usr/bin/env bash

while read -r line; do
    echo "${line}"
    if jq -e . >/dev/null 2>&1 <<<"${line}"
    then
        echo "${line}" | ipfs pubsub pub -- "org.podcastindex.podping.Podping.json"
    fi
done < <(poetry run python3 -u hive-watcher.py --json --old 1)
