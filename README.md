# fluent-bit

![Version: 0.19.16-bb.1](https://img.shields.io/badge/Version-0.19.16--bb.1-informational?style=flat-square) ![AppVersion: 1.8.11](https://img.shields.io/badge/AppVersion-1.8.11-informational?style=flat-square)

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
| elasticsearch.name | string | `"logging-ek"` |  |
| istio.enabled | bool | `false` |  |
| additionalOutputs.disableDefault | bool | `false` |  |
| additionalOutputs.elasticsearch.host | string | `""` |  |
| additionalOutputs.elasticsearch.port | int | `9200` |  |
| additionalOutputs.elasticsearch.user | string | `"elastic"` |  |
| additionalOutputs.elasticsearch.password | string | `""` |  |
| additionalOutputs.elasticsearch.tls | bool | `true` |  |
| additionalOutputs.elasticsearch.tlsVerify | bool | `false` |  |
| additionalOutputs.elasticsearch.caCert | string | `""` |  |
| additionalOutputs.elasticsearch.additionalConfig | object | `{}` |  |
| storage_buffer.path | string | `"/var/log/flb-storage/"` |  |
| storage.total_limit_size | string | `"10G"` |  |
| kind | string | `"DaemonSet"` | DaemonSet or Deployment |
| replicaCount | int | `1` | Only applicable if kind=Deployment |
| image.repository | string | `"registry1.dso.mil/ironbank/opensource/fluent/fluent-bit"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.tag | string | `"1.8.11"` |  |
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
| env[0] | object | `{"name":"FLUENT_ELASTICSEARCH_PASSWORD","valueFrom":{"secretKeyRef":{"key":"elastic","name":"logging-ek-es-elastic-user"}}}` | Pointing to specific Big Bang ECK stack "logging-ek" elastic user for auth. |
| envFrom | list | `[]` |  |
| extraContainers | list | `[]` |  |
| metricsPort | int | `2020` |  |
| extraPorts | list | `[]` |  |
| extraVolumes[0] | object | `{"hostPath":{"path":"/var/log/flb-storage/","type":"DirectoryOrCreate"},"name":"flb-storage"}` | Mount /var/log/flb-storage/ for the storage buffer, recommended for production systems. |
| extraVolumes[1].secret.secretName | string | `"logging-ek-es-http-certs-public"` |  |
| extraVolumes[1].name | string | `"elasticsearch-certs"` |  |
| extraVolumeMounts[0] | object | `{"mountPath":"/var/log/flb-storage/","name":"flb-storage"}` | Mount /var/log/flb-storage/ for the storage buffer, recommended for production systems. |
| extraVolumeMounts[1].mountPath | string | `"/etc/elasticsearch/certs/"` |  |
| extraVolumeMounts[1].name | string | `"elasticsearch-certs"` |  |
| updateStrategy | object | `{}` |  |
| existingConfigMap | string | `""` |  |
| networkPolicy.enabled | bool | `false` |  |
| luaScripts | object | `{}` |  |
| config.service | string | `"[SERVICE]\n    Daemon Off\n    Flush 1\n    Log_Level {{ .Values.logLevel }}\n    Parsers_File parsers.conf\n    Parsers_File custom_parsers.conf\n    HTTP_Server On\n    HTTP_Listen 0.0.0.0\n    HTTP_Port {{ .Values.metricsPort }}\n    # -- Setting up storage buffer on filesystem and slighty upping backlog mem_limit value.\n    storage.path {{ .Values.storage_buffer.path }}\n    storage.sync normal\n    storage.backlog.mem_limit 15M\n    Health_Check On\n"` |  |
| config.inputs | string | `"[INPUT]\n    Name tail\n    Path /var/log/containers/*.log\n    # -- Excluding fluentbit logs from sending to ECK, along with gatekeeper-audit logs which are shipped by clusterAuditor.\n    Exclude_Path /var/log/containers/*fluent*.log,/var/log/containers/*gatekeeper-audit*.log\n    Parser containerd\n    Tag kube.*\n    Mem_Buf_Limit 50MB\n    Skip_Long_Lines On\n    storage.type filesystem\n\n[INPUT]\n    Name systemd\n    Tag host.*\n    Systemd_Filter _SYSTEMD_UNIT=kubelet.service\n    Read_From_Tail On\n    storage.type filesystem\n"` |  |
| config.filters | string | `"[FILTER]\n    Name kubernetes\n    Match kube.*\n    Kube_CA_File /var/run/secrets/kubernetes.io/serviceaccount/ca.crt\n    Kube_Token_File /var/run/secrets/kubernetes.io/serviceaccount/token\n    Merge_Log On\n    Merge_Log_Key log_processed\n    K8S-Logging.Parser On\n    K8S-Logging.Exclude Off\n"` |  |
| config.outputs | string | `"[OUTPUT]\n    Name es\n    Match kube.*\n    # -- Pointing to Elasticsearch service installed by ECK, based off EK name \"logging-ek\", update elasticsearch.name above to update.\n    Host {{ .Values.elasticsearch.name }}-es-http\n    HTTP_User elastic\n    HTTP_Passwd ${FLUENT_ELASTICSEARCH_PASSWORD}\n    Logstash_Format On\n    Retry_Limit False\n    Replace_Dots On\n    tls On\n    tls.verify On\n    tls.ca_file /etc/elasticsearch/certs/ca.crt\n    storage.total_limit_size {{ .Values.storage.total_limit_size }}\n\n[OUTPUT]\n    Name es\n    Match host.*\n    # -- Pointing to Elasticsearch service installed by ECK, based off EK name \"logging-ek\", update elasticsearch.name above to update.\n    Host {{ .Values.elasticsearch.name }}-es-http\n    HTTP_User elastic\n    HTTP_Passwd ${FLUENT_ELASTICSEARCH_PASSWORD}\n    Logstash_Format On\n    Logstash_Prefix node\n    Retry_Limit False\n    tls On\n    tls.verify On\n    tls.ca_file /etc/elasticsearch/certs/ca.crt\n    storage.total_limit_size {{ .Values.storage.total_limit_size }}\n"` |  |
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
| openshift | bool | `false` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.
