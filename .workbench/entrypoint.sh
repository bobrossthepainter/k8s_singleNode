#! /bin/sh

if [ ! -d /work/.secrets ]; then
    echo "Secrets not found. Decrypting..."
    /work/decrypt.sh
fi

exec "$@"
