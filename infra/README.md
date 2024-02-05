# Vault Infra Deploy

```
.
├── 0-modules
│   ├── 0-gcp-iam               # terraform module
│   ├── 2-vault-server-auth     # terraform module
│   ├── 3-vault-client-vso      # helm chart
│   └── 4-auth-kubernetes       # terraform module
│
├── env-dev                     # environment
│   ├── 0-preparing
│   ├── 1-vault-server-init
│   ├── 2-vault-server-auth
│   ├── 3-vault-client-vso
│   └── 4-vault-server-config
│
├── env-prod                    # environment
└── env-stage                   # environment
```

## How to deploy a new Vault Client

The section will guide you on how to set up a Vault Client, including the following information:
1. Deploy the Vault Secret Operator(vso)
2. Configure Vault Kubernetes authentication

### 1. Deploy the Vault Secret Operator(vso)

To create VSO helm value file in the `3-vault-client-vso` folder and replace the `VAULT_SERVER_ADDRESS` parameter.
```
$ kubectl config use-context ${K8S_CONTEXT}
$ helm install vault-secrets-operator ../../0-modules/3-vault-client-vso -n vault-secrets-operator-system -f local-k8s-2-vso.values.yaml
```

The Helm chart extends from `https://helm.releases.hashicorp.com/vault-secrets-operator `. Here, we use a custom module that extends the functionality to configure Kubernetes service accounts for few namespaces. For more information, refer to the source code in `infra/0-modules/3-vault-client-vso`.

### 2. Setting Kubernetes service account in Vault Server

This step involves setting the Kubernetes service account token in Vault Server. This allows the Vault Server to use the service account to obtain a short-term authentication token, which it can then use to update secretes in belong namespace.

```hcl
module "local-k8s-2-auth" {
  source = "./../../0-modules/4-auth-kubernetes"

  client_k8s_path = "local-k8s-2-auth-mount"

  client_auths = [
    {
      host               = "{LOCAL_K8S_2_HOST_ADDRESS}"
      ca_cert            = data.kubernetes_secret.local-k8s-2-vault-auth-sa.data["ca.crt"]
      token_reviewer_jwt = data.kubernetes_secret.local-k8s-2-vault-auth-sa.data["token"]
    }
  ]

  ## serviceAccount.namespaces
  ## ref: infra/env-dev/3-vault-client-vso/local-k8s-2-vso.values.yaml
  service_account_namespaces = [
    "payment",
    "vault-secrets-operator-system",
    ...
  ]
}


```