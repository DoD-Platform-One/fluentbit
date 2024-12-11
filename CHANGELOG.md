# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.48.3-bb.1] - 2024-12-11

### Changed

- Updated Kyverno policy due to deprecated field

## [0.48.3-bb.0] - 2024-12-04

### Updated

- Updated fluent-bit: 3.2.1 -> 3.2.2

## [0.48.2-bb.0] - 2024-11-26

### Changed

- Updated gluon: 0.5.8 -> 0.5.12
- Updated fluent-bit: 3.1.9 -> 3.2.1
  
## [0.47.10-bb.1] - 2024-10-18

### Changed

- Updated gluon: 0.5.4 -> 0.5.8
- Updated configmap-reload v0.13.1 -> v0.14.0
- Added the maintenance track annotation and badge

## [0.47.10-bb.0] - 2024-10-02

### Changed

- Updated fluent-bit: 3.1.7 -> 3.1.9

## [0.47.9-bb.1] - 2024-09-19

### Removed

- Removed duplicate parsers in the customParsers field in values.yaml

## [0.47.9-bb.0] - 2024-09-04

### Changed

- Updated fluent-bit: 3.1.6 -> 3.1.7
- Updated gluon 0.5.3 -> 0.5.4

## [0.47.7-bb.0] - 2024-08-16

### Changed

- Updated fluent-bit: 3.1.5 -> 3.1.6

## [0.47.6-bb.1] - 2024-08-15

### Changed

- Parse labels through tpl

## [0.47.6-bb.0] - 2024-08-14

### Changed

- Updated fluent-bit: 3.1.4 -> 3.1.5
- Updated gluon: 0.5.2 -> 0.5.3

## [0.47.5-bb.1] - 2024-08-01

### Changed

- Remove redundant items from test/test-values.yaml

## [0.47.5-bb.0] - 2024-07-26

### Changed

- Updated fluent-bit: 3.1.3 -> 3.1.4
- Updated gluon: 0.5.0 -> 0.5.2

## [0.47.3-bb.0] - 2024-07-16

### Changed

- Updated fluent-bit: 3.1.2 -> 3.1.3

## [0.47.2-bb.0] - 2024-07-16

### Changed

- Updated fluent-bit: 3.1.1 -> 3.1.2  

## [0.47.1-bb.0] - 2024-06-10

### Changed

- Updated fluent-bit: 3.0.6 -> 3.1.1

## [0.46.10-bb.2] - 2024-07-02

### Removed

- Removed shared authPolicies set at the Istio level

## [0.46.10-bb.1] - 2024-06-25

### Added

- Added missing drift changed in chart

## [0.46.10-bb.0] - 2024-06-10

### Changed

- Updated fluent-bit: 3.0.4 -> 3.0.6

## [0.46.7-bb.1] - 2024-05-23

### Added

- Added `cluster` label to the log stream

## [0.46.7-bb.0] - 2024-05-22

### Changed

- Updated fluent-bit: 3.0.3 -> 3.0.4

## [0.46.5-bb.0] - 2024-05-08

### Added

- Gluon 0.4.9 -> 0.5.0
- fluent-bit 3.0.2 -> 3.0.3
- configmap-reload v0.12.0 -> v0.13.0

## [0.46.2-bb.2] - 2024-05-02

### Added

- Drop unnecessary labels for Loki 3.0 support

## [0.46.2-bb.1] - 2024-04-29

### Added

- Support for custom network policies via values yaml

## [0.46.2-bb.0]

### Changed

- Updated upstream helm chart tag `0.46.2-bb.0`
- Updated fluent-bit image to `3.0.2` from IB

## [0.46.1-bb.0]

### Changed

- Updated upstream helm chart tag `0.46.1-bb.0`
- Updated fluent-bit image to `3.0.1` from IB
- Updated gluon to `0.4.9`

## [0.46.0-bb.0]

### Changed

- Updated upstream helm chart tag `0.46.0-bb.0`
- Updated fluent-bit image to `3.0.0` from IB

## [0.43.0-bb.4]

### Changed

- Use help functions for sidecar label

## [0.43.0-bb.3]

### Changed

- Adding Sidecar to deny egress that is external to istio services
- Adding customServiceEntries to allow egress to override sidecar

## [0.43.0-bb.2]

### Changed

- Added Openshift updates for deploying fluentbit into Openshift cluster

## [0.43.0-bb.1]

### Changed

- Updated configmap for custom Elasticsearch settings

## [0.43.0-bb.0]

### Changed

- Updated upstream helm chart tag `0.43.0-bb.0`
- Updated fluent-bit image to `2.2.2` from IB

## [0.40.0-bb.0]

### Changed

- Updated upstream helm chart tag `0.40.0-bb.0`
- Updated fluent-bit image to `2.2.1` from IB

## [0.39.0-bb.5]

### Added

- Added configuration for Match in elasticsearch, fluentd and loki output
- Added document for configuration to reduce elasticsearch index sizing

## [0.39.0-bb.4]

### Added

- Added istio `allow-nothing` policy
- Added istio `allow-monitoring` policy
- Added istio custom policy template

## [0.39.0-bb.3]

### Changed

- jq image version from 1.6 -> 1.7 in bbtests
- upgrade gluon repo and version to 0.4.4

## [0.39.0-bb.2]

### Changed

- Updating OSCAL Component file.

## [0.39.0-bb.1]

### Changed

- Updated configmap-reload to `v0.12.0`

## [0.39.0-bb.0]

### Changed

- Updated upstream helm chart tag `0.39.0-bb.0`
- Updated fluent-bit image to `2.1.10` from IB

## [0.37.0-bb.3] - 2023-10-24

### Changed

- updating contributing file to link to external github contributions

## [0.37.0-bb.2]

### Changed

- Modified OSCAL Version for fluentbit and updated to 1.1.1

## [0.37.0-bb.1]

### Changed

- Kyverno ClusterPolicy template syntax for kyverno 1.10.X+

## [0.37.0-bb.0]

### Changed

- Updated upstream helm chart tag `0.37.0-bb.0`
- Updated fluent-bit image to `2.1.8` from IB

## [0.30.4-bb.0]

### Changed

- Updated upstream helm chart tag `0.30.4-bb.0`
- Updated fluent-bit image to `2.1.4` from IB

## [0.28.0-bb.1]

### Added

- Added SCC for OpenShift

## [0.28.0-bb.0]

### Changed

- Updated upstream helm chart tag `0.28.0-bb.0`
- Updated fluent-bit image to `2.1.2` from IB

## [0.27.0-bb.0]

### Changed

- Updated upstream helm chart tag `0.27.0-bb.0`
- Updated fluent-bit image to `2.0.11` from IB

## [0.25.0-bb.3]

### Changed

- Set namespace on kyverno policies

## [0.25.0-bb.2]

### Added

- Added elastic cert sync capability

## [0.25.0-bb.1]

### Added

- Added elastic password sync capability

## [0.25.0-bb.0]

### Changed

- Updated upstream helm chart tag `0.25.0-bb.0`
- Updated fluent-bit image to `2.0.10` from IB

## [0.24.0-bb.0]

### Changed

- Updated upstream helm chart tag `0.24.0-bb.0`
- Updated fluent-bit image to `2.0.9` from IB

## [0.21.7-bb.1]

### Changed

- Chart renamed to `fluentbit` for OCI consistency

## [0.21.7-bb.0]

### Changed

- Updated upstream helm chart tag `0.21.7`
- Updated fluent-bit image to `2.0.8` from IB

## [0.21.4-bb.0]

### Changed

- Updated upstream helm chart tag `0.21.4`
- Updated fluent-bit image to `2.0.6` from IB

## [0.21.2-bb.1]

### Changed

- added prometheus Rules to deployment

## [0.21.2-bb.0]

### Changed

- Updated upstream helm chart tag `0.21.2`
- Updated fluent-bit image to `2.0.5` from IB

## [0.20.10-bb.0]

### Changed

- Updated upstream helm chart tag `0.20.10`
- Updated fluent-bit image to `2.0.3` from IB

## [0.20.9-bb.0]

### Changed

- Updated upstream helm chart tag `0.20.9`
- Updated fluent-bit image to `1.9.9` from IB

## [0.20.8-bb.0]

### Changed

- Updated upstream helm chart tag `0.20.8`
- Updated fluent-bit image to `1.9.8` from IB

## [0.20.6-bb.1]

### Added

- Added support for tlsConfig and scheme values in the serviceMonitor

### Removed

- Removed mTLS exception for metrics

## [0.20.6-bb.0]

### Changed

- Updated upstream helm chart tag `0.20.6`
- Updated fluent-bit image to `1.9.7` from IB

## [0.20.3-bb.1]

### Changed

- Added storage buffer limit for all `additionalOutputs`

## [0.20.3-bb.0]

### Changed

- Updated upstream helm chart tag `0.20.3`
- Updated fluent-bit image to `1.9.6` from IB
- Updated gluon image to `0.2.10`

## [0.20.2-bb.1]

### Changed

- Added `Suppress_Type_Name  On` to es OUTPUT configmap

## [0.20.2-bb.0]

### Changed

- Updated upstream helm chart tag 0.20.2
- Updated fluent-bit image to 1.9.4 image from IB

## [0.20.0-bb.1]

### Changed

- Removed exclusion of gatekeeper audit logs from tailing

## [0.20.0-bb.0]

### Changed

- Updated upstream helm chart tag 0.20.0
- Updated fluent-bit image to 1.9.3 image from IB

## [0.19.20-bb.3]

### Added

- Add default PeerAuthentication to enable STRICT mTLS

## [0.19.20-bb.2]

### Added

- Added Tempo Zipkin Egress Policy

## [0.19.20-bb.1]

### Changed

- Updated /var/log mount to be readOnly

## [0.19.20-bb.0]

### Changed

- Updated upstream helm chart tag 0.19.20
- Updated fluent-bit image to 1.8.13 image from IB

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
