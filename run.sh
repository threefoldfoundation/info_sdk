#!/bin/bash
set -ex
cd ~/code/github/threefoldfoundation/info_tfgridsdk
open http://localhost:3000/sdk/index.html#/intro
tfweb -c threefold_sites.toml

