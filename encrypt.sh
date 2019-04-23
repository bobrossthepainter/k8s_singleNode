#! /bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

tar -cvvzf - .secrets/ | gpg --passphrase "${SECRETS_KEY}" --batch --yes -ac -o ${DIR}/secrets.tgz.enc
