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