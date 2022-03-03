# fluent-bit

![Version: 0.19.19-bb.3](https://img.shields.io/badge/Version-0.19.19--bb.3-informational?style=flat-square) ![AppVersion: 1.8.12](https://img.shields.io/badge/AppVersion-1.8.12-informational?style=flat-square)

Fast and lightweight log processor and forwarder or Linux, OSX and BSD family operating systems.

## Upstream References
* <https://fluentbit.io/>

* <https://github.com/fluent/fluent-bit/>

## Learn More
* [Application Overview](docs/overview.md)
* [Other Documentation](docs/)

## Pre-Requisites

* Kubernetes Cluster deployed
* Kubernetes config installed in `~/.kube/config`
* Helm installed

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

* Clone down the repository
* cd into directory
```bash
helm install fluent-bit chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| elasticsearch | object | `{"name":""}` | Configuration for Elasticsearch interaction |
| elasticsearch.name | string | `""` | Name is only used at the BB level for host templating |
| istio | object | `{"enabled":false}` | Configuration for Istio interaction |
| istio.enabled | bool | `false` | Toggle currently only controls NetworkPolicies |
| additionalOutputs | object | `{"disableDefault":false,"elasticsearch":{"additionalConfig":{},"caCert":"","host":"","password":"","port":9200,"tls":true,"tlsVerify":false,"user":"elastic"},"fluentd":{"additionalConfig":{},"caCert":"","host":"","password":"","port":24224,"sharedKey":"","tls":true,"tlsVerify":false,"user":""},"loki":{"additionalConfig":{},"caCert":"","host":"","password":"","port":3100,"tls":false,"tlsVerify":false,"user":""},"s3":{"additionalConfig":{"total_file_size":"1M","upload_timeout":"1m","use_put_object":"On"},"aws_access_key_id":"","aws_secret_access_key":"","bucket":"","existingSecret":"","region":"us-east-1"}}` | Additional Outputs for Big Bang, these are wrappers to simplify the config of outputs and extend whatever is specified under the `outputs` values |
| additionalOutputs.disableDefault | bool | `false` | Option to disable the default elastic output configured under `outputs`, this only works at the Big Bang chart level |
| additionalOutputs.elasticsearch | object | `{"additionalConfig":{},"caCert":"","host":"","password":"","port":9200,"tls":true,"tlsVerify":false,"user":"elastic"}` | Options to enable an additional elastic output |
| additionalOutputs.elasticsearch.tls | bool | `true` | Toggle on TLS |
| additionalOutputs.elasticsearch.tlsVerify | bool | `false` | Verify TLS certificates, requires a caCert to be specified |
| additionalOutputs.elasticsearch.caCert | string | `""` | Full ca.crt specified as multiline string, see example |
| additionalOutputs.elasticsearch.additionalConfig | object | `{}` | Reference configuration parameters provided by Fluentbit - https://docs.fluentbit.io/manual/pipeline/outputs/elasticsearch |
| additionalOutputs.fluentd | object | `{"additionalConfig":{},"caCert":"","host":"","password":"","port":24224,"sharedKey":"","tls":true,"tlsVerify":false,"user":""}` | Options to enable a fluentd output |
| additionalOutputs.fluentd.sharedKey | string | `""` | Overriden by username and password |
| additionalOutputs.fluentd.tls | bool | `true` | Toggle on TLS |
| additionalOutputs.fluentd.tlsVerify | bool | `false` | Verify TLS certificates, requires a caCert to be specified |
| additionalOutputs.fluentd.caCert | string | `""` | Full ca.crt specified as multiline string, see example |
| additionalOutputs.fluentd.additionalConfig | object | `{}` | Reference configuration parameters provided by Fluentbit - https://docs.fluentbit.io/manual/pipeline/outputs/forward |
| additionalOutputs.loki | object | `{"additionalConfig":{},"caCert":"","host":"","password":"","port":3100,"tls":false,"tlsVerify":false,"user":""}` | Options to enable a loki output |
| additionalOutputs.loki.user | string | `""` | User and Password are optional - only required if running proxy in front of Loki, see https://grafana.com/docs/loki/latest/operations/authentication/ |
| additionalOutputs.loki.tls | bool | `false` | Toggle on TLS - disabled by default to support in cluster Loki |
| additionalOutputs.loki.tlsVerify | bool | `false` | Verify TLS certificates, requires a caCert to be specified |
| additionalOutputs.loki.caCert | string | `""` | Full ca.crt specified as multiline string, see example |
| additionalOutputs.loki.additionalConfig | object | `{}` | Reference configuration parameters provided by Fluentbit - https://docs.fluentbit.io/manual/pipeline/outputs/loki |
| additionalOutputs.s3 | object | `{"additionalConfig":{"total_file_size":"1M","upload_timeout":"1m","use_put_object":"On"},"aws_access_key_id":"","aws_secret_access_key":"","bucket":"","existingSecret":"","region":"us-east-1"}` | Options to enable a S3 output |
| additionalOutputs.s3.existingSecret | string | `""` | Reference an existing secret with your access and secret key, must contain key values pairs for AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY |
| additionalOutputs.s3.additionalConfig | object | `{"total_file_size":"1M","upload_timeout":"1m","use_put_object":"On"}` | Reference configuration parameters provided by Fluentbit - https://docs.fluentbit.io/manual/pipeline/outputs/s3 |
| storage_buffer | object | `{"path":"/var/log/flb-storage/"}` | Options to configure hostPath mounted storage buffer for production use Specified in fluentbit service configuration section below see https://docs.fluentbit.io/manual/administration/buffering-and-storage |
| storage | object | `{"total_limit_size":"10G"}` | Limits the number of Chunks that exists in the file system for a certain logical output destination.  If one destination reaches the storage.total_limit_size limit, the oldest Chunk from the queue for that logical output destination will be discarded. see https://docs.fluentbit.io/manual/administration/buffering-and-storage |
| kind | string | `"DaemonSet"` | DaemonSet or Deployment |
| replicaCount | int | `1` | Only applicable if kind=Deployment |
| image.repository | string | `"registry1.dso.mil/ironbank/opensource/fluent/fluent-bit"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.tag | string | `"1.8.12"` |  |
| networkPolicies.enabled | bool | `false` |  |
| networkPolicies.controlPlaneCidr | string | `"0.0.0.0/0"` |  |
| testFramework.enabled | bool | `false` |  |
| testFramework.image.repository | string | `"busybox"` |  |
| testFramework.image.pullPolicy | string | `"Always"` |  |
| testFramework.image.tag | string | `"latest"` |  |
| imagePullSecrets[0].name | string | `"private-registry"` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.name | string | `nil` |  |
| rbac.create | bool | `true` |  |
| rbac.nodeAccess | bool | `false` |  |
| podSecurityPolicy.create | bool | `false` |  |
| podSecurityPolicy.annotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| hostNetwork | bool | `false` |  |
| dnsPolicy | string | `"ClusterFirst"` |  |
| dnsConfig | object | `{}` |  |
| hostAliases | list | `[]` |  |
| securityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.seLinuxOptions.type | string | `"spc_t"` |  |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `2020` |  |
| service.labels | object | `{}` |  |
| service.annotations | object | `{}` |  |
| serviceMonitor.enabled | bool | `false` |  |
| prometheusRule.enabled | bool | `false` |  |
| dashboards.enabled | bool | `false` |  |
| dashboards.labelKey | string | `"grafana_dashboard"` |  |
| dashboards.annotations | object | `{}` |  |
| lifecycle | object | `{}` |  |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.httpGet.path | string | `"/api/v1/health"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| resources | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.hosts | list | `[]` |  |
| ingress.extraHosts | list | `[]` |  |
| ingress.tls | list | `[]` |  |
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
| priorityClassName | string | `""` |  |
| env | object | `{}` |  |
| envFrom | list | `[]` |  |
| extraContainers | list | `[]` |  |
| flush | int | `1` |  |
| metricsPort | int | `2020` |  |
| extraPorts | list | `[]` |  |
| extraVolumes[0] | object | `{"hostPath":{"path":"/var/log/flb-storage/","type":"DirectoryOrCreate"},"name":"flb-storage"}` | Mount /var/log/flb-storage/ for the storage buffer, recommended for production systems. |
| extraVolumeMounts[0] | object | `{"mountPath":"/var/log/flb-storage/","name":"flb-storage"}` | Mount /var/log/flb-storage/ for the storage buffer, recommended for production systems. |
| updateStrategy | object | `{}` |  |
| existingConfigMap | string | `""` |  |
| networkPolicy.enabled | bool | `false` |  |
| luaScripts | object | `{}` |  |
| config.service | string | `"[SERVICE]\n    Daemon Off\n    Flush {{ .Values.flush }}\n    Log_Level {{ .Values.logLevel }}\n    Parsers_File parsers.conf\n    Parsers_File custom_parsers.conf\n    HTTP_Server On\n    HTTP_Listen 0.0.0.0\n    HTTP_Port {{ .Values.metricsPort }}\n    # -- Setting up storage buffer on filesystem and slighty upping backlog mem_limit value.\n    storage.path {{ .Values.storage_buffer.path }}\n    storage.sync normal\n    storage.backlog.mem_limit 15M\n    Health_Check On\n"` |  |
| config.inputs | string | `"[INPUT]\n    Name tail\n    Path /var/log/containers/*.log\n    # -- Excluding fluentbit logs from sending to ECK, along with gatekeeper-audit logs which are shipped by clusterAuditor.\n    Exclude_Path /var/log/containers/*fluent*.log,/var/log/containers/*gatekeeper-audit*.log\n    Parser containerd\n    Tag kube.*\n    Mem_Buf_Limit 50MB\n    Skip_Long_Lines On\n    storage.type filesystem\n\n[INPUT]\n    Name systemd\n    Tag host.*\n    Systemd_Filter _SYSTEMD_UNIT=kubelet.service\n    Read_From_Tail On\n    storage.type filesystem\n"` |  |
| config.filters | string | `"[FILTER]\n    Name kubernetes\n    Match kube.*\n    Kube_CA_File /var/run/secrets/kubernetes.io/serviceaccount/ca.crt\n    Kube_Token_File /var/run/secrets/kubernetes.io/serviceaccount/token\n    Merge_Log On\n    Merge_Log_Key log_processed\n    K8S-Logging.Parser On\n    K8S-Logging.Exclude Off\n"` |  |
| config.outputs | string | `""` |  |
| config.customParsers | string | `"[PARSER]\n    Name docker_no_time\n    Format json\n    Time_Keep Off\n    Time_Key time\n    Time_Format %Y-%m-%dT%H:%M:%S.%L\n\n[PARSER]\n    Name containerd\n    Format regex\n    Regex ^(?<time>[^ ]+) (?<stream>stdout|stderr) (?<logtag>[^ ]*) (?<log>.*)$\n    Time_Key time\n    Time_Format %Y-%m-%dT%H:%M:%S.%L%z\n    Time_Keep On\n\n[PARSER]\n    Name   apache\n    Format regex\n    Regex  ^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \\[(?<time>[^\\]]*)\\] \"(?<method>\\S+)(?: +(?<path>[^\\\"]*?)(?: +\\S*)?)?\" (?<code>[^ ]*) (?<size>[^ ]*)(?: \"(?<referer>[^\\\"]*)\" \"(?<agent>[^\\\"]*)\")?$\n    Time_Key time\n    Time_Format %d/%b/%Y:%H:%M:%S %z\n\n[PARSER]\n    Name   apache2\n    Format regex\n    Regex  ^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \\[(?<time>[^\\]]*)\\] \"(?<method>\\S+)(?: +(?<path>[^ ]*) +\\S*)?\" (?<code>[^ ]*) (?<size>[^ ]*)(?: \"(?<referer>[^\\\"]*)\" \"(?<agent>[^\\\"]*)\")?$\n    Time_Key time\n    Time_Format %d/%b/%Y:%H:%M:%S %z\n\n[PARSER]\n    Name   apache_error\n    Format regex\n    Regex  ^\\[[^ ]* (?<time>[^\\]]*)\\] \\[(?<level>[^\\]]*)\\](?: \\[pid (?<pid>[^\\]]*)\\])?( \\[client (?<client>[^\\]]*)\\])? (?<message>.*)$\n\n[PARSER]\n    Name   nginx\n    Format regex\n    Regex ^(?<remote>[^ ]*) (?<host>[^ ]*) (?<user>[^ ]*) \\[(?<time>[^\\]]*)\\] \"(?<method>\\S+)(?: +(?<path>[^\\\"]*?)(?: +\\S*)?)?\" (?<code>[^ ]*) (?<size>[^ ]*)(?: \"(?<referer>[^\\\"]*)\" \"(?<agent>[^\\\"]*)\")?$\n    Time_Key time\n    Time_Format %d/%b/%Y:%H:%M:%S %z\n\n[PARSER]\n    Name   json\n    Format json\n    Time_Key time\n    Time_Format %d/%b/%Y:%H:%M:%S %z\n\n[PARSER]\n    Name        docker\n    Format      json\n    Time_Key    time\n    Time_Format %Y-%m-%dT%H:%M:%S.%L\n    Time_Keep   On\n\n[PARSER]\n    Name        syslog\n    Format      regex\n    Regex       ^\\<(?<pri>[0-9]+)\\>(?<time>[^ ]* {1,2}[^ ]* [^ ]*) (?<host>[^ ]*) (?<ident>[a-zA-Z0-9_\\/\\.\\-]*)(?:\\[(?<pid>[0-9]+)\\])?(?:[^\\:]*\\:)? *(?<message>.*)$\n    Time_Key    time\n    Time_Format %b %d %H:%M:%S\n"` |  |
| config.extraFiles | object | `{}` |  |
| volumeMounts[0].name | string | `"config"` |  |
| volumeMounts[0].mountPath | string | `"/fluent-bit/etc/fluent-bit.conf"` |  |
| volumeMounts[0].subPath | string | `"fluent-bit.conf"` |  |
| volumeMounts[1].name | string | `"config"` |  |
| volumeMounts[1].mountPath | string | `"/fluent-bit/etc/custom_parsers.conf"` |  |
| volumeMounts[1].subPath | string | `"custom_parsers.conf"` |  |
| daemonSetVolumes[0].name | string | `"varlog"` |  |
| daemonSetVolumes[0].hostPath.path | string | `"/var/log"` |  |
| daemonSetVolumes[1].name | string | `"varlibdockercontainers"` |  |
| daemonSetVolumes[1].hostPath.path | string | `"/var/lib/docker/containers"` |  |
| daemonSetVolumes[2].name | string | `"etcmachineid"` |  |
| daemonSetVolumes[2].hostPath.path | string | `"/etc/machine-id"` |  |
| daemonSetVolumes[2].hostPath.type | string | `"File"` |  |
| daemonSetVolumeMounts[0].name | string | `"varlog"` |  |
| daemonSetVolumeMounts[0].mountPath | string | `"/var/log"` |  |
| daemonSetVolumeMounts[1].name | string | `"varlibdockercontainers"` |  |
| daemonSetVolumeMounts[1].mountPath | string | `"/var/lib/docker/containers"` |  |
| daemonSetVolumeMounts[1].readOnly | bool | `true` |  |
| daemonSetVolumeMounts[2].name | string | `"etcmachineid"` |  |
| daemonSetVolumeMounts[2].mountPath | string | `"/etc/machine-id"` |  |
| daemonSetVolumeMounts[2].readOnly | bool | `true` |  |
| args | list | `[]` |  |
| command | list | `[]` |  |
| initContainers | list | `[]` |  |
| logLevel | string | `"info"` |  |
| openshift | bool | `false` | Toggle for Openshift, currently only controls NetworkPolicy changes |
| bbtests | object | `{"enabled":false,"scripts":{"envs":{"desired_version":"{{ .Values.image.tag }}","fluent_host":"http://{{ include \"fluent-bit.fullname\" . }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.port }}"},"image":"registry1.dso.mil/ironbank/stedolan/jq:1.6"}}` | Values used for Big Bang CI testing |
| bbtests.enabled | bool | `false` | Toggles test manifests |
| bbtests.scripts.image | string | `"registry1.dso.mil/ironbank/stedolan/jq:1.6"` | Image used to run script tests, must include curl and jq |
| bbtests.scripts.envs | object | `{"desired_version":"{{ .Values.image.tag }}","fluent_host":"http://{{ include \"fluent-bit.fullname\" . }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.port }}"}` | Envs that are passed into the script runner pod |
| bbtests.scripts.envs.fluent_host | string | `"http://{{ include \"fluent-bit.fullname\" . }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.port }}"` | Hostname/port to contact Fluentbit |
| bbtests.scripts.envs.desired_version | string | `"{{ .Values.image.tag }}"` | Version that should be running |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.
