#!/usr/bin/env sh

set -ex

unseal () {
vault operator unseal -tls-skip-verify $(grep 'Key 1:' /vault/file/keys | awk '{print $NF}')
vault operator unseal -tls-skip-verify $(grep 'Key 2:' /vault/file/keys | awk '{print $NF}')
vault operator unseal -tls-skip-verify $(grep 'Key 3:' /vault/file/keys | awk '{print $NF}')
}

init () {
vault operator init -tls-skip-verify > /vault/file/keys
}

log_in () {
   export ROOT_TOKEN=$(grep 'Initial Root Token:' /vault/file/keys | awk '{print $NF}')
   vault login -tls-skip-verify $ROOT_TOKEN
}

create_token () {
   vault token create -tls-skip-verify -id $MY_VAULT_TOKEN
}

if [ -s /vault/file/keys ]; then
   unseal
else
   init
   unseal
   log_in
   create_token
fi

vault status -tls-skip-verify > /vault/file/status
