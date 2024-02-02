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
