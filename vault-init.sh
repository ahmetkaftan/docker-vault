#!/usr/bin/env sh

set -ex

unseal () {
vault operator unseal $(grep 'Key 1:' /vault/file/keys | awk '{print $NF}')
vault operator unseal $(grep 'Key 2:' /vault/file/keys | awk '{print $NF}')
vault operator unseal $(grep 'Key 3:' /vault/file/keys | awk '{print $NF}')
}

init () {
vault operator init > /vault/file/keys
echo $(grep 'Initial Root Token:' /vault/file/keys | awk '{print $NF}') > /vault/file/vault-root-token

}

if [ -s /vault/file/keys ]; then
   unseal
else
   init
   unseal
fi

vault status > /vault/file/status