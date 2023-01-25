{{- define "fluent-bit.pod" -}}
serviceAccountName: {{ include "fluent-bit.serviceAccountName" . }}
{{- with .Values.imagePullSecrets }}
imagePullSecrets:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- if .Values.priorityClassName }}
priorityClassName: {{ .Values.priorityClassName }}
{{- end }}
{{- with .Values.podSecurityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.terminationGracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
{{- end }}
hostNetwork: {{ .Values.hostNetwork }}
dnsPolicy: {{ .Values.dnsPolicy }}
{{- with .Values.dnsConfig }}
dnsConfig:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.hostAliases }}
hostAliases:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.initContainers }}
initContainers:
{{- if kindIs "string" . }}
  {{- tpl . $ | nindent 2 }}
{{- else }}
  {{-  toYaml . | nindent 2 }}
{{- end -}}
{{- end }}
containers:
  - name: {{ default .Chart.Name .Values.nameOverride }}
  {{- with .Values.securityContext }}
    securityContext:
      {{- toYaml . | nindent 6 }}
  {{- end }}
    image: "{{ .Values.image.repository }}:{{ default .Chart.AppVersion .Values.image.tag }}"
    imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- if or .Values.env .Values.envWithTpl }}
    env:
    {{- with .Values.env }}
      {{- toYaml . | nindent 6 }}
    {{- end }}
    {{- range $item := .Values.envWithTpl }}
      - name: {{ $item.name }}
        value: {{ tpl $item.value $ | quote }}
    {{- end }}
  {{- end }}
  {{- $additionalElastic := (and .Values.additionalOutputs.elasticsearch.host .Values.additionalOutputs.elasticsearch.user .Values.additionalOutputs.elasticsearch.password .Values.additionalOutputs.elasticsearch.port) }}
  {{- $additionalFluentd := (and .Values.additionalOutputs.fluentd.host (or (and .Values.additionalOutputs.fluentd.user .Values.additionalOutputs.fluentd.password) .Values.additionalOutputs.fluentd.sharedKey) .Values.additionalOutputs.fluentd.port) }}
  {{- $additionalS3 := (and .Values.additionalOutputs.s3.bucket (or (and .Values.additionalOutputs.s3.aws_secret_access_key .Values.additionalOutputs.s3.aws_access_key_id) .Values.additionalOutputs.s3.existingSecret)  .Values.additionalOutputs.s3.region ) }}
  {{- $additionalLoki := (and .Values.additionalOutputs.loki.host .Values.additionalOutputs.loki.port) }}
  {{- if or .Values.envFrom $additionalElastic $additionalFluentd $additionalS3 $additionalLoki }}
    envFrom:
      {{- if .Values.envFrom }}
      {{- toYaml .Values.envFrom | nindent 6 }}
      {{- end }}
      {{- if $additionalElastic }}
      - secretRef:
          name: external-es-config
      {{- end }}
      {{- if $additionalFluentd }}
      - secretRef:
          name: external-fluentd-config
      {{- end }}
      {{- if and $additionalS3 .Values.additionalOutputs.s3.existingSecret }}
      - secretRef:
          name: {{ .Values.additionalOutputs.s3.existingSecret }}
      {{- else if $additionalS3 }}
      - secretRef:
          name: external-s3-config
      {{- end }}
      {{- if $additionalLoki }}
      - secretRef:
          name: external-loki-config
      {{- end }}
  {{- end }}
  {{- if .Values.args }}
    args:
    {{- toYaml .Values.args | nindent 6 }}
  {{- end}}
  {{- if .Values.command }}
    command:
    {{- toYaml .Values.command | nindent 6 }}
  {{- end }}
    ports:
      - name: http
        containerPort: {{ .Values.metricsPort }}
        protocol: TCP
    {{- if .Values.extraPorts }}
      {{- range .Values.extraPorts }}
      - name: {{ .name }}
        containerPort: {{ .containerPort }}
        protocol: {{ .protocol }}
      {{- end }}
    {{- end }}
  {{- with .Values.lifecycle }}
    lifecycle:
      {{- toYaml . | nindent 6 }}
  {{- end }}
    livenessProbe:
      {{- toYaml .Values.livenessProbe | nindent 6 }}
    readinessProbe:
      {{- toYaml .Values.readinessProbe | nindent 6 }}
  {{- with .Values.resources }}
    resources:
      {{- toYaml . | nindent 6 }}
  {{- end }}
    volumeMounts:
      {{- toYaml .Values.volumeMounts | nindent 6 }}
    {{- range $key, $val := .Values.config.extraFiles }}
      - name: config
        mountPath: /fluent-bit/etc/{{ $key }}
        subPath: {{ $key }}
    {{- end }}
    {{- range $key, $value := .Values.luaScripts }}
      - name: luascripts
        mountPath: /fluent-bit/scripts/{{ $key }}
        subPath: {{ $key }}
    {{- end }}
    {{- if and .Values.additionalOutputs.elasticsearch.tlsVerify .Values.additionalOutputs.elasticsearch.caCert }}
      - name: external-es-ca-cert
        mountPath: /etc/external-es/certs/
    {{- end }}
    {{- if and .Values.additionalOutputs.fluentd.tlsVerify .Values.additionalOutputs.fluentd.caCert }}
      - name: external-fluentd-ca-cert
        mountPath: /etc/external-fluentd/certs/
    {{- end }}
    {{- if $additionalS3 }}
      - name: fluentbit-temp
        mountPath: /tmp/fluent-bit/
    {{- end }}
    {{- if and .Values.additionalOutputs.loki.tlsVerify .Values.additionalOutputs.loki.caCert }}
      - name: external-loki-ca-cert
        mountPath: /etc/external-loki/certs/
    {{- end }}
    {{- if eq .Values.kind "DaemonSet" }}
      {{- toYaml .Values.daemonSetVolumeMounts | nindent 6 }}
    {{- end }}
    {{- if .Values.extraVolumeMounts }}
      {{- toYaml .Values.extraVolumeMounts | nindent 6 }}
    {{- end }}
  {{- if .Values.extraContainers }}
    {{- toYaml .Values.extraContainers | nindent 2 }}
  {{- end }}
volumes:
  - name: config
    configMap:
      name: {{ if .Values.existingConfigMap }}{{ .Values.existingConfigMap }}{{- else }}{{ include "fluent-bit.fullname" . }}{{- end }}
{{- if gt (len .Values.luaScripts) 0 }}
  - name: luascripts
    configMap:
      name: {{ include "fluent-bit.fullname" . }}-luascripts
{{- end }}
{{- if eq .Values.kind "DaemonSet" }}
  {{- toYaml .Values.daemonSetVolumes | nindent 2 }}
{{- end }}
{{- if .Values.extraVolumes }}
  {{- toYaml .Values.extraVolumes | nindent 2 }}
{{- end }}
{{- if and .Values.additionalOutputs.elasticsearch.tlsVerify .Values.additionalOutputs.elasticsearch.caCert }}
  - name: external-es-ca-cert
    secret:
      secretName: external-es-ca-cert
{{- end }}
{{- if and .Values.additionalOutputs.fluentd.tlsVerify .Values.additionalOutputs.fluentd.caCert }}
  - name: external-fluentd-ca-cert
    secret:
      secretName: external-fluentd-ca-cert
{{- end }}
{{- if $additionalS3 }}
  - name: fluentbit-temp
    emptyDir: {}
{{- end }}
{{- if and .Values.additionalOutputs.loki.tlsVerify .Values.additionalOutputs.loki.caCert }}
  - name: external-loki-ca-cert
    secret:
      secretName: external-loki-ca-cert
{{- end }}


{{- with .Values.nodeSelector }}
nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.affinity }}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.tolerations }}
tolerations:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
