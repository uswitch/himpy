#!/usr/bin/env bash
set -e

deb-s3 upload --preserve-versions --bucket private-apt-repo --endpoint=s3-eu-west-1.amazonaws.com --sign 93934BF9 pkg/*.deb
