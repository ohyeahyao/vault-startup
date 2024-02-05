# Vault Startup

```
.
├── infra               # Vault Infra Deploy
├── secret-management   # Vault Secret Management
├── my-gpg-key.asc      # GPG Private Key
└── .sops.yaml          # SOPS Configuration 
```

## Vault Infra Deploy
When you are deploying and setting vault server, you might check out [documentation](./infra/README.md) on infra.

## Vault Secret Management
If you wanna deploy secret into your multiple clusters, you might want to check out [documentation](./secret-management/README.md) on secret-management.

# Other Notes
## GPG 
### Generate GPG Key
```bash
$ gpg --batch --full-generate-key <<EOF
%no-protection
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Comment: sops secrets
Name-Real: my-sops-key
EOF
```

### Export to File
```bash
gpg --export-secret-keys -a my-sops-key > ./my-gpg-key.asc
```

### Import GPG Key
```bash
gpg --import ./my-gpg-key.asc
```

---
**NOTE**
my-gpg-key.asc is PGP private key for presentation, And does not commit it in production.

---