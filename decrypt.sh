#! /bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

gpg --passphrase "${SECRETS_KEY}" -a --batch --yes --decrypt ${DIR}/secrets.tgz.enc | tar -xzvf - -C ${DIR}/
