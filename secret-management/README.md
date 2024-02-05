# Vault Secret Management
```
.
├── 0-terraform-modules       # Terraform Modules
│
├── dev.local-k8s-1           # k8s cluster context name
│   ├── app                   # k8s namespaces
│   │   ├── .secrets          # secrets
│   │   │    └── app1.json    # encrypt secret json using SOPS
│   │   │    └── app2.json    # encrypt secret json using SOPS
│   │   └── app1.tf           # vault secret setting
│   │   └── app2.tf           # vault secret setting
│   │
│   └── logging               # k8s namespaces
│
├── dev.local-k8s-2           # k8s cluster context name    
├── stage.gke-stage-cluster   # k8s cluster context name
├── .... other context
└── prod.gke-prod-cluster     # k8s cluster context name
```

# Follow steps below:
## 1. import GPG Key for SOPS
```bash
$ gpg --import ./my-gpg-key.asc
```

## 2. Deploy Secret
```bash
$ cd dev.local-k8s-1
$ terraform init
$ terraform apply
```

# Create Secret for a new Cluster (context)

## 1. GPG Key
you can use exists GPG Key or create one for yourself:
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

## 2. create a directory for cluster
```bash
$ SECRET_ENV=dev
$ SECRET_CONTEXT=local-k8s-2
$ DIRECTORY_NAME="${ENV}.${SECRET_CONTEXT}"
$ mkdir $DIRECTORY_NAME
```

## 3. create a folder for namespace

```
$ cd $DIRECTORY_NAME
$ SECRET_NAMESPACE=payment
$ mkdir ${SECRET_NAMESPACE}/.secrets
```

## 4. create a secret and encrypt using SOPS

To create a secret within a `.secrets` directory that contains secret information. could be follows:

```
echo '{"DB_PASSWORD": "database password here","AWS_ACCESS_KEY_ID": "aws access key id here","AWS_SECRET_ACCESS_KEY": "aws secret access key here"}' > ${SECRET_NAMESPACE}/.secrets/service-sample.json

```

Next, encrypt the file using the SOPS with the `my-gpg-key.asc` GPG key.
```
sops -e --in-place ${SECRET_NAMESPACE}/.secrets/service-sample.json
```

Now, you can confidently add the JSON secret file to version control.

---
**NOTE**
my-gpg-key.asc is PGP private key for presentation, And does not commit it to version control in production.
