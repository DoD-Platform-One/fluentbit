# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.15.8-bb.0]
### Changed
- Pointing to upstream helm chart tag 0.15.8
- Updating fluent-bit image to 1.7.4 image from IronBank

## [0.15.3-bb.1]
### Changed
- SecurityContext settings for a more ideal setup for production environments

## [0.15.3-bb.0]
### Changed
- Pointing to upstream helm chart tag 0.15.3
- Updating fluent-bit image to 1.7.2 image from IronBank
- Fluent-bit configuration tuning for production environments

### Added
- containerd parser

## [0.7.5-bb.0]
### Changed
- Pointing to upstream helm chart maintained by fluent team.
- Modified hostPath mounts in templates/_pod.tpl since K3S/D clusters fail with no /etc/machine-id path
