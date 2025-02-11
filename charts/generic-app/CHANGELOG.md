## `generic-app` chart

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
