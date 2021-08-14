#!/bin/bash

if [ -z "${DIGITALOCEAN_TOKEN}" ]; then
  echo "The DIGITALOCEAN_TOKEN env variable needs set to run this script."
  exit 1
fi

for cluster in $(doctl kubernetes cluster list -o json | jq -r '.[]["id"]'); do
  curl -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${DIGITALOCEAN_TOKEN}" \
  "https://api.digitalocean.com/v2/kubernetes/clusters/${cluster}" \
  | jq .
done

