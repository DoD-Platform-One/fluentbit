# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.7.5-bb.0]
### Changed
- Pointing to upstream helm chart maintained by fluent team.
- Modified hostPath mounts in templates/_pod.tpl since K3S/D clusters fail with no /etc/machine-id path
