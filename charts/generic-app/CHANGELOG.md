## `generic-app` chart

Version 0.4.0

- Add multi-node support: nodeSelector, affinity (nodeAffinity, podAffinity, podAntiAffinity), and tolerations for both deployments and statefulSets
- Add support for configurable storage class and access modes for volumes (both deployments and statefulSets)
- Add smart defaults for secretProviderClass: fileName auto-generated from secretKey (e.g., DATABASE_URL -> database-url), envName defaults to secretKey
- Refactor: Extract common pod spec into shared template to reduce code duplication and ensure consistency between deployments and statefulSets
- Refactor: volume names are no longer prepended with vol- for consistency between deployments and statefulsets

Version 0.3.0

- Replace legacy secrets management with integration of external secrets manager

Version 0.2.2

- Fixed incorrect regex escaping in regexReplaceAll function arguments.

Version 0.2.1

- Fixed incorrect string representation in regexReplaceAll function arguments.

Version 0.2.0

- Add support for specifying what domain to deploy to.

Version 0.1.3

- Add support for no subdomain being provided, which will just use the base domain.

Version 0.1.2

- Add support for multiple containers with ingress annotations.
- Add support for `subPath` in config file mounts, to allow mounting individual files to existing directories.
- `targetPort` will now default to use `port` if `targetPort` is not defined, else it will use `80`.
- `ingress` will now use `letsencrypt-prod` issuer by default

Version 0.1.1

- Number of containers with ingress annotations can now be 0 or 1, as it should be to allow for services
  that don't need ingress.

Version 0.1.0

- Initial release
