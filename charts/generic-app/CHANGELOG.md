## `generic-app` chart

Version 0.3.5

- Fix missing conditional for secretProviderClass and syncKubernetesSecrets

Version 0.3.4

- Add support for CSI secrets as env variables

Version 0.3.3

- Remove extraneous imagePullSecrets from deployment and statefulsets

Version 0.3.2

- Add default identity ID in secret provider class

Version 0.3.1

- Fix missing conditionals in secret provider class

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
