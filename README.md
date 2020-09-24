# Vault Server - docker-compose
Vault server has a unique mechanism during initializing in production mode. Running Vault in docker container needs manual action to make it work serve properly after installation.

In this repo you will find an easy way to deploy Vault in production mode without manual action. You can set a token sudo priviliges with MY_VAULT_TOKEN variable, just use the following command:

```
docker-compose up -d
```

After inital setup you can stop and start the vault container with docker-compose down/up your vault server will be unsealed automatically.

Even unsealing is automatic if you need unseal keys you can find it in _/vault/file/keys_ file in vault container.
   