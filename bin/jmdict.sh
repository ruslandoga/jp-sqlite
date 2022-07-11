#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

curl 'http://ftp.edrdg.org/pub/Nihongo/JMdict_e.gz' -O
gunzip JMdict_e.gz
mix jmdict
