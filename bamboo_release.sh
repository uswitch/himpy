#!/usr/bin/env bash
set -e

export AWS_ACCESS_KEY_ID=$bamboo_AWS_SA_BUILDAGENT_KEYID
export AWS_SECRET_ACCESS_KEY=$bamboo_AWS_SA_BUILDAGENT_PASSWORD

./release.sh
