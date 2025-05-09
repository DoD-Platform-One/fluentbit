<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# fluentbit

![Version: 0.48.10-bb.0](https://img.shields.io/badge/Version-0.48.10--bb.0-informational?style=flat-square) ![AppVersion: 4.0.1](https://img.shields.io/badge/AppVersion-4.0.1-informational?style=flat-square) ![Maintenance Track: bb_integrated](https://img.shields.io/badge/Maintenance_Track-bb_integrated-green?style=flat-square)

Fast and lightweight log processor and forwarder or Linux, OSX and BSD family operating systems.

## Upstream References

- <https://fluentbit.io/>
- <https://github.com/fluent/fluent-bit/>

## Upstream Release Notes

- [Find the upstream fluent-bit release notes here](https://fluentbit.io/announcements/)

## Learn More

- [Application Overview](docs/overview.md)
- [Other Documentation](docs/)

## Pre-Requisites

- Kubernetes Cluster deployed
- Kubernetes config installed in `~/.kube/config`
- Helm installed

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

- Clone down the repository
- cd into directory

```bash
helm install fluentbit chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| elasticsearch | object | `{"name":""}` | Configuration for Elasticsearch interaction |
| elasticsearch.name | string | `""` | Name is only used at the BB level for host templating |
| istio | object | `{"enabled":false,"hardened":{"customAuthorizationPolicies":[],"customServiceEntries":[],"enabled":false,"outboundTrafficPolicyMode":"REGISTRY_ONLY"},"mtls":{"mode":"STRICT"}}` | Configuration for Istio interaction |
| istio.enabled | bool | `false` | Toggle currently only controls NetworkPolicies |
| istio.mtls | object | `{"mode":"STRICT"}` | Default peer authentication setting |
| istio.mtls.mode | string | `"STRICT"` | STRICT = Allow only mutual TLS traffic PERMISSIVE = Allow both plain text and mutual TLS traffic |
| additionalOutputs | object | `{"disableDefault":false,"elasticsearch":{"additionalConfig":{},"caCert":"","host":"","match":["kube.*","host.*"],"password":"","port":9200,"tls":true,"tlsVerify":false,"user":"elastic"},"fluentd":{"additionalConfig":{},"caCert":"","host":"","match":["kube.*","host.*"],"password":"","port":24224,"sharedKey":"","tls":true,"tlsVerify":false,"user":""},"loki":{"additionalConfig":{},"caCert":"","host":"","match":["kube.*","host.*"],"password":"","port":3100,"tls":false,"tlsVerify":false,"user":""},"s3":{"additionalConfig":{"total_file_size":"1M","upload_timeout":"1m","use_put_object":"On"},"aws_access_key_id":"","aws_secret_access_key":"","bucket":"","existingSecret":"","match":["kube.*","host.*"],"region":"us-east-1"}}` | Additional Outputs for Big Bang, these are wrappers to simplify the config of outputs and extend whatever is specified under the `outputs` values |
| additionalOutputs.disableDefault | bool | `false` | Option to disable the default elastic output configured under `outputs`, this only works at the Big Bang chart level |
| additionalOutputs.elasticsearch | object | `{"additionalConfig":{},"caCert":"","host":"","match":["kube.*","host.*"],"password":"","port":9200,"tls":true,"tlsVerify":false,"user":"elastic"}` | Options to enable an additional elastic output |
| additionalOutputs.elasticsearch.tls | bool | `true` | Toggle on TLS |
| additionalOutputs.elasticsearch.tlsVerify | bool | `false` | Verify TLS certificates, requires a caCert to be specified |
| additionalOutputs.elasticsearch.caCert | string | `""` | Full ca.crt specified as multiline string, see example |
| additionalOutputs.elasticsearch.additionalConfig | object | `{}` | Reference configuration parameters provided by Fluentbit - https://docs.fluentbit.io/manual/pipeline/outputs/elasticsearch |
| additionalOutputs.fluentd | object | `{"additionalConfig":{},"caCert":"","host":"","match":["kube.*","host.*"],"password":"","port":24224,"sharedKey":"","tls":true,"tlsVerify":false,"user":""}` | Options to enable a fluentd output |
| additionalOutputs.fluentd.sharedKey | string | `""` | Overriden by username and password |
| additionalOutputs.fluentd.tls | bool | `true` | Toggle on TLS |
| additionalOutputs.fluentd.tlsVerify | bool | `false` | Verify TLS certificates, requires a caCert to be specified |
| additionalOutputs.fluentd.caCert | string | `""` | Full ca.crt specified as multiline string, see example |
| additionalOutputs.fluentd.additionalConfig | object | `{}` | Reference configuration parameters provided by Fluentbit - https://docs.fluentbit.io/manual/pipeline/outputs/forward |
| additionalOutputs.loki | object | `{"additionalConfig":{},"caCert":"","host":"","match":["kube.*","host.*"],"password":"","port":3100,"tls":false,"tlsVerify":false,"user":""}` | Options to enable a loki output |
| additionalOutputs.loki.user | string | `""` | User and Password are optional - only required if running proxy in front of Loki, see https://grafana.com/docs/loki/latest/operations/authentication/ |
| additionalOutputs.loki.tls | bool | `false` | Toggle on TLS - disabled by default to support in cluster Loki |
| additionalOutputs.loki.tlsVerify | bool | `false` | Verify TLS certificates, requires a caCert to be specified |
| additionalOutputs.loki.caCert | string | `""` | Full ca.crt specified as multiline string, see example |
| additionalOutputs.loki.additionalConfig | object | `{}` | Reference configuration parameters provided by Fluentbit - https://docs.fluentbit.io/manual/pipeline/outputs/loki |
| additionalOutputs.s3 | object | `{"additionalConfig":{"total_file_size":"1M","upload_timeout":"1m","use_put_object":"On"},"aws_access_key_id":"","aws_secret_access_key":"","bucket":"","existingSecret":"","match":["kube.*","host.*"],"region":"us-east-1"}` | Options to enable a S3 output |
| additionalOutputs.s3.existingSecret | string | `""` | Reference an existing secret with your access and secret key, must contain key values pairs for AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY |
| additionalOutputs.s3.additionalConfig | object | `{"total_file_size":"1M","upload_timeout":"1m","use_put_object":"On"}` | Reference configuration parameters provided by Fluentbit - https://docs.fluentbit.io/manual/pipeline/outputs/s3 |
| storage_buffer | object | `{"path":"/var/log/flb-storage/"}` | Options to configure hostPath mounted storage buffer for production use Specified in fluentbit service configuration section below see https://docs.fluentbit.io/manual/administration/buffering-and-storage |
| storage | object | `{"total_limit_size":"10G"}` | Limits the number of Chunks that exists in the file system for a certain logical output destination. If one destination reaches the storage.total_limit_size limit, the oldest Chunk from the queue for that logical output destination will be discarded. see https://docs.fluentbit.io/manual/administration/buffering-and-storage |
| kind | string | `"DaemonSet"` | DaemonSet or Deployment |
| replicaCount | int | `1` | Only applicable if kind=Deployment |
| image.repository | string | `"registry1.dso.mil/ironbank/opensource/fluent/fluent-bit"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.tag | string | `"4.0.1"` |  |
| networkPolicies.enabled | bool | `false` |  |
| networkPolicies.controlPlaneCidr | string | `"0.0.0.0/0"` |  |
| networkPolicies.additionalPolicies | list | `[]` |  |
| testFramework.enabled | bool | `false` |  |
| testFramework.namespace | string | `nil` |  |
| testFramework.image.repository | string | `"busybox"` |  |
| testFramework.image.pullPolicy | string | `"Always"` |  |
| testFramework.image.tag | string | `"latest"` |  |
| testFramework.image.digest | string | `nil` |  |
| imagePullSecrets[0].name | string | `"private-registry"` |  |
| nameOverride | string | `"fluent-bit"` |  |
| fullnameOverride | string | `""` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.name | string | `nil` |  |
| rbac.create | bool | `true` |  |
| rbac.nodeAccess | bool | `false` |  |
| rbac.eventsAccess | bool | `false` |  |
| podSecurityPolicy.create | bool | `false` |  |
| podSecurityPolicy.annotations | object | `{}` |  |
| podSecurityPolicy.runAsUser.rule | string | `"RunAsAny"` |  |
| podSecurityPolicy.seLinux.rule | string | `"RunAsAny"` |  |
| openShift.enabled | bool | `false` |  |
| openShift.securityContextConstraints.create | bool | `true` |  |
| openShift.securityContextConstraints.name | string | `""` |  |
| openShift.securityContextConstraints.annotations | object | `{}` |  |
| openShift.securityContextConstraints.runAsUser.type | string | `"RunAsAny"` |  |
| openShift.securityContextConstraints.seLinuxContext.type | string | `"MustRunAs"` |  |
| openShift.securityContextConstraints.existingName | string | `""` |  |
| podSecurityContext | object | `{}` |  |
| hostNetwork | bool | `false` |  |
| dnsPolicy | string | `"ClusterFirst"` |  |
| dnsConfig | object | `{}` |  |
| hostAliases | list | `[]` |  |
| securityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.seLinuxOptions.type | string | `"spc_t"` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `2020` |  |
| service.internalTrafficPolicy | string | `nil` |  |
| service.loadBalancerClass | string | `nil` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.labels | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.externalIPs | list | `[]` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.additionalEndpoints | list | `[]` |  |
| prometheusRule.enabled | bool | `false` |  |
| prometheusRule.additionalLabels | object | `{}` |  |
| prometheusRule.rules[0].alert | string | `"fluentbitJobAbsent"` |  |
| prometheusRule.rules[0].annotations.message | string | `"Fluent Bit job not present for 10m"` |  |
| prometheusRule.rules[0].expr | string | `"absent(up{job=\"fluentbit\", namespace=\"logging\"})"` |  |
| prometheusRule.rules[0].for | string | `"10m"` |  |
| prometheusRule.rules[0].labels.severity | string | `"critical"` |  |
| prometheusRule.rules[1].alert | string | `"FluentdLowNumberOfPods"` |  |
| prometheusRule.rules[1].expr | string | `"avg without (instance) (up{job=\"fluentbit\"}) < .20"` |  |
| prometheusRule.rules[1].for | string | `"10m"` |  |
| prometheusRule.rules[1].annotations | string | `nil` |  |
| prometheusRule.rules[1].labels.severity | string | `"critical"` |  |
| prometheusRule.rules[2].alert | string | `"LogsNotFlowing"` |  |
| prometheusRule.rules[2].expr | string | `"sum(rate(fluentd_output_status_num_records_total{}[4h])) by (tag) < .001"` |  |
| prometheusRule.rules[2].for | string | `"30m"` |  |
| prometheusRule.rules[2].annotations | string | `nil` |  |
| prometheusRule.rules[2].labels.severity | string | `"critical"` |  |
| prometheusRule.rules[3].alert | string | `"NoOutputBytesProcessed"` |  |
| prometheusRule.rules[3].expr | string | `"rate(fluentbit_output_proc_bytes_total[5m]) == 0"` |  |
| prometheusRule.rules[3].annotations.message | string | `"Fluent Bit instance {{ $labels.instance }}'s output plugin {{ $labels.name }} has not processed any\nbytes for at least 15 minutes.\n"` |  |
| prometheusRule.rules[3].for | string | `"15m"` |  |
| prometheusRule.rules[3].labels.severity | string | `"critical"` |  |
| dashboards.enabled | bool | `false` |  |
| dashboards.labelKey | string | `"grafana_dashboard"` |  |
| dashboards.labelValue | int | `1` |  |
| dashboards.annotations | object | `{}` |  |
| dashboards.namespace | string | `""` |  |
| dashboards.deterministicUid | bool | `false` |  |
| lifecycle | object | `{}` |  |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.httpGet.path | string | `"/api/v1/health"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| resources | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.ingressClassName | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.hosts | list | `[]` |  |
| ingress.extraHosts | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| autoscaling.vpa.enabled | bool | `false` |  |
| autoscaling.vpa.annotations | object | `{}` |  |
| autoscaling.vpa.controlledResources | list | `[]` |  |
| autoscaling.vpa.maxAllowed | object | `{}` |  |
| autoscaling.vpa.minAllowed | object | `{}` |  |
| autoscaling.vpa.updatePolicy.updateMode | string | `"Auto"` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.maxReplicas | int | `3` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `75` |  |
| autoscaling.customRules | list | `[]` |  |
| autoscaling.behavior | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `false` |  |
| podDisruptionBudget.annotations | object | `{}` |  |
| podDisruptionBudget.maxUnavailable | string | `"30%"` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| labels | object | `{}` |  |
| annotations | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| minReadySeconds | string | `nil` |  |
| terminationGracePeriodSeconds | string | `nil` |  |
| priorityClassName | string | `""` |  |
| env | object | `{}` |  |
| envWithTpl | list | `[]` |  |
| envFrom | list | `[]` |  |
| extraContainers | list | `[]` |  |
| flush | int | `1` |  |
| metricsPort | int | `2020` |  |
| extraPorts | list | `[]` |  |
| extraVolumes[0] | object | `{"hostPath":{"path":"/var/log/flb-storage/","type":"DirectoryOrCreate"},"name":"flb-storage"}` | Mount /var/log/flb-storage/ for the storage buffer, recommended for production systems. |
| extraVolumeMounts[0] | object | `{"mountPath":"/var/log/flb-storage/","name":"flb-storage","readOnly":false}` | Mount /var/log/flb-storage/ for the storage buffer, recommended for production systems. |
| updateStrategy | object | `{}` |  |
| existingConfigMap | string | `""` |  |
| networkPolicy.enabled | bool | `false` |  |
| luaScripts | object | `{}` |  |
| config.service | string | `"[SERVICE]\n    Daemon Off\n    Flush {{ .Values.flush }}\n    Log_Level {{ .Values.logLevel }}\n    Parsers_File /fluent-bit/etc/parsers.conf\n    Parsers_File /fluent-bit/etc/conf/custom_parsers.conf\n    HTTP_Server On\n    HTTP_Listen 0.0.0.0\n    HTTP_Port {{ .Values.metricsPort }}\n    # -- Setting up storage buffer on filesystem and slighty upping backlog mem_limit value.\n    storage.path {{ .Values.storage_buffer.path }}\n    storage.sync normal\n    storage.backlog.mem_limit 15M\n    Health_Check On\n"` |  |
| config.inputs | string | `"[INPUT]\n    Name tail\n    Path /var/log/containers/*.log\n    # -- Excluding fluentbit logs from sending to ECK, along with gatekeeper-audit logs which are shipped by clusterAuditor.\n    Exclude_Path /var/log/containers/*fluent*.log\n    Parser containerd\n    Tag kube.*\n    Mem_Buf_Limit 50MB\n    Skip_Long_Lines On\n    storage.type filesystem\n\n[INPUT]\n    Name systemd\n    Tag host.*\n    Systemd_Filter _SYSTEMD_UNIT=kubelet.service\n    Read_From_Tail On\n    storage.type filesystem\n"` |  |
| config.filters | string | `""` |  |
| config.outputs | string | `""` |  |
| config.upstream | object | `{}` |  |
| config.customParsers | string | `"[PARSER]\n    Name docker_no_time\n    Format json\n    Time_Keep Off\n    Time_Key time\n    Time_Format %Y-%m-%dT%H:%M:%S.%L\n\n[PARSER]\n    Name containerd\n    Format regex\n    Regex ^(?<time>[^ ]+) (?<stream>stdout\|stderr) (?<logtag>[^ ]*) (?<log>.*)$\n    Time_Key time\n    Time_Format %Y-%m-%dT%H:%M:%S.%L%z\n    Time_Keep On\n\n[PARSER]\n    Name        syslog\n    Format      regex\n    Regex       ^\\<(?<pri>[0-9]+)\\>(?<time>[^ ]* {1,2}[^ ]* [^ ]*) (?<host>[^ ]*) (?<ident>[a-zA-Z0-9_\\/\\.\\-]*)(?:\\[(?<pid>[0-9]+)\\])?(?:[^\\:]*\\:)? *(?<message>.*)$\n    Time_Key    time\n    Time_Format %b %d %H:%M:%S\n"` |  |
| config.extraFiles | object | `{}` |  |
| volumeMounts[0].name | string | `"config"` |  |
| volumeMounts[0].mountPath | string | `"/fluent-bit/etc/conf"` |  |
| daemonSetVolumes[0].name | string | `"varlog"` |  |
| daemonSetVolumes[0].hostPath.path | string | `"/var/log"` |  |
| daemonSetVolumes[1].name | string | `"varlibdockercontainers"` |  |
| daemonSetVolumes[1].hostPath.path | string | `"/var/lib/docker/containers"` |  |
| daemonSetVolumes[2].name | string | `"etcmachineid"` |  |
| daemonSetVolumes[2].hostPath.path | string | `"/etc/machine-id"` |  |
| daemonSetVolumes[2].hostPath.type | string | `"File"` |  |
| daemonSetVolumeMounts[0].name | string | `"varlog"` |  |
| daemonSetVolumeMounts[0].mountPath | string | `"/var/log"` |  |
| daemonSetVolumeMounts[0].readOnly | bool | `true` |  |
| daemonSetVolumeMounts[1].name | string | `"varlibdockercontainers"` |  |
| daemonSetVolumeMounts[1].mountPath | string | `"/var/lib/docker/containers"` |  |
| daemonSetVolumeMounts[1].readOnly | bool | `true` |  |
| daemonSetVolumeMounts[2].name | string | `"etcmachineid"` |  |
| daemonSetVolumeMounts[2].mountPath | string | `"/etc/machine-id"` |  |
| daemonSetVolumeMounts[2].readOnly | bool | `true` |  |
| command[0] | string | `"/fluent-bit/bin/fluent-bit"` |  |
| args[0] | string | `"--workdir=/fluent-bit/etc"` |  |
| args[1] | string | `"--config=/fluent-bit/etc/conf/fluent-bit.conf"` |  |
| initContainers | list | `[]` |  |
| logLevel | string | `"info"` |  |
| openshift | bool | `false` | Toggle for Openshift, currently only controls NetworkPolicy changes |
| loki | object | `{"enabled":false}` | List of enabled Big Bang log storage package(s), used to control networkPolicies and auth only |
| elasticsearchKibana.enabled | bool | `false` |  |
| bbtests | object | `{"enabled":false,"scripts":{"envs":{"desired_version":"{{ .Values.image.tag }}","fluent_host":"http://{{ include \"fluent-bit.fullname\" . }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.port }}"},"image":"registry1.dso.mil/ironbank/big-bang/base:2.1.0"}}` | Values used for Big Bang CI testing |
| bbtests.enabled | bool | `false` | Toggles test manifests |
| bbtests.scripts.image | string | `"registry1.dso.mil/ironbank/big-bang/base:2.1.0"` | Image used to run script tests, must include curl and jq |
| bbtests.scripts.envs | object | `{"desired_version":"{{ .Values.image.tag }}","fluent_host":"http://{{ include \"fluent-bit.fullname\" . }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.port }}"}` | Envs that are passed into the script runner pod |
| bbtests.scripts.envs.fluent_host | string | `"http://{{ include \"fluent-bit.fullname\" . }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.port }}"` | Hostname/port to contact Fluentbit |
| bbtests.scripts.envs.desired_version | string | `"{{ .Values.image.tag }}"` | Version that should be running |
| hotReload.enabled | bool | `false` |  |
| hotReload.image.repository | string | `"registry1.dso.mil/ironbank/opensource/jimmidyson/configmap-reload"` |  |
| hotReload.image.tag | string | `"v0.15.0"` |  |
| hotReload.image.digest | string | `nil` |  |
| hotReload.image.pullPolicy | string | `"IfNotPresent"` |  |
| hotReload.resources | object | `{}` |  |
| hotReload.extraWatchVolumes | list | `[]` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

