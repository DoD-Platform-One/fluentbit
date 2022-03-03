# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
## [0.19.19-bb.3]
### Changed
- Moved all BB elastic defaults out of package values

## [0.19.19-bb.2]
### Added
- Added `additionalOutputs.loki` and required template changes to simplify additional loki output

## [0.19.19-bb.1]
### Changed
- Updated upstream helm chart tag 0.19.19
- Added `additionalOutputs.loki` and required template changes to simplify additional loki output

## [0.19.19-bb.0]
### Changed
- Updated upstream helm chart tag 0.19.19
- Updated fluent-bit image to 1.8.12 image from IB

## [0.19.16-bb.6]
### Changed
- Corrected duplicate annotations tag in chart.yaml 

## [0.19.16-bb.5]
### Changed
- Update Chart.yaml to follow new standardization for release automation
- Added renovate check to update new standardization

## [0.19.16-bb.4]
### Changed
- Relocated `bbtests` to `values.yaml`

## [0.19.16-bb.3]
### Added
- Added `additionalOutputs.fluentd` and required template changes to simplify additional fluentd output

## [0.19.16-bb.2]
### Added
- Added OSCAL component for Fluentbit component

## [0.19.16-bb.1]
### Added
- Added `additionalOutputs` values to provide clean interface for adding new outputs
- Added `additionalOutputs.elasticsearch` and required template changes to simplify additional elastic output

## [0.19.16-bb.0]
### Changed
- Updated to upstream helm chart tag 0.19.16
- Updated fluent-bit image to 1.8.11 image from IB

## [0.19.9-bb.0]
### Changed
- Updated to upstream helm chart tag 0.19.9
- Updated fluent-bit image to 1.8.10 image from IB

## [0.19.3-bb.0]
### Changed
- Updated to upstream helm chart tag 0.19.3
- Updated fluent-bit image to 1.8.9 image from IB

## [0.16.6-bb.1]
### Changed
- Wait longer for the endpoint to come up in the CI test
- Replace bbtest library with gluon

## [0.16.6-bb.0]
### Changed
- Updated to upstream helm chart tag 0.16.6
- Updated fluent-bit image to 1.8.6 image from IronBank

## [0.16.5-bb.1]
### Added
- Added a new configuration value -- storage.total_limit_size -- to limit storage space

### Changed
- Changed curl call in CI test script to use retry logic

## [0.16.5-bb.0]
### Changed
- Updated to upstream helm chart tag 0.16.5
- Updated fluent-bit image to 1.8.5 image from IronBank

## [0.16.1-bb.1]
### Added
- updated README.md

## [0.16.1-bb.0]
### Added
- Pointing to upstream helm chart tag 0.16.1
- Updating fluent-bit image to 1.8.1 image from IronBank

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
