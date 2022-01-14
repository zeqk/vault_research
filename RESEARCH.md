## CLI Basics

Put

```bash
make vault "kv put secret/creds2 passcode4=my-long-passcode" 
```

```bash
make vault "kv list secret" 
```

```bash
make vault "kv get secret/creds2" 
make vault "kv get -format json secret/creds2"
make vault "kv get -field=BearerTokens -format json secret/creds2"
```

## Agent

### Template

make vault ""

https://github.com/hashicorp/vault-guides/tree/master/secrets/dotnet-vault

```bash
make vault "agent -config=/src/dotnet-vault/config-vault-agent-template.hcl"
```