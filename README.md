# infra-helm-charts

This repository contains the Helm charts for deploying the infrastructure components in the Kubernetes cluster.

## Setup

This repository makes use of pre-commit hooks to generate Helm chart schemas.

1. Install [`pre-commit`](https://pre-commit.com/#install)
2. Install [`helm-schema`](https://github.com/dadav/helm-schema) by running:
   ```bash
   helm plugin install https://github.com/dadav/helm-schema
   ```
3. Run `pre-commit install` followed by `pre-commit install-hooks` to install the pre-commit hooks

## `helm-schema`

`helm-schema` is a Helm plugin that generates JSON schemas for Helm charts. This is useful for validating the values files against the schema.

You can run:

```bash
helm schema -k additionalProperties -a
```

manually, or commit your changes and let the pre-commit hook run it for you.
