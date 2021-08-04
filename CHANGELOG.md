# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
## [0.15.15-bb.2]
### Added
- Add Elasticsearch CA and turned on tls.verify
- Add port 53 TCP to dns NetworkPolicy to allow proper name resolution
- Add port 5353 TCP to dns NetworkPolicy for openshift.

## [0.15.15-bb.1]
### Added
- Add openshift toggle. If it's set, add port 5353 egress rule.

## [0.15.15-bb.0]
### Changed
- Bumped upstream Helm chart version to 0.15.15
- Bumped Fluent Bit image tag to 1.7.9

## [0.15.14-bb.1]
### Fixed
- Added missing network policy for istio sidecar scraping

## [0.15.14-bb.0]
### Changed
- Bumped upstream Helm chart version to 0.15.14
- Bumped dependency bb-test-lib version to 0.5.2
- Bumped Fluent Bit image tag to 1.7.8

## [0.15.8-bb.5]
### Added
- kube-api-egress Network Policy Template to allow fluent-bit to communicate with the cluster kube-api.
- networkPolicies.controlPlaneCidr value for kube-api-egress specific Network Policy template.

## [0.15.8-bb.4]
### Changed
- Conditionals on network policies updated to toggle appropriately (specifically monitoring and istio)

## [0.15.8-bb.3]
### Added
- Added optional NetworkPolicies for isolation
## [0.15.8-bb.2]
### Added
- `bb-test-lib` as a dependency
- Test script to hit Fluentbit API and do some basic validation that records have been input and output

## [0.15.8-bb.1]
### Changed
- Re-adding namespace value for grafana dashboard configmap template

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
