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
    image: {{ include "fluent-bit.image" (merge .Values.image (dict "tag" (default .Chart.AppVersion .Values.image.tag))) | quote }}
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
  {{- with .Values.command }}
    command:
      {{- toYaml . | nindent 6 }}
  {{- end }}
  {{- if or .Values.args .Values.hotReload.enabled }}
    args:
      {{- toYaml .Values.args | nindent 6 }}
    {{- if .Values.hotReload.enabled }}
      - --enable-hot-reload
    {{- end }}
  {{- end}}
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
      - name: config
        mountPath: /fluent-bit/etc/conf
    {{- if or .Values.luaScripts .Values.hotReload.enabled }}
      - name: luascripts
        mountPath: /fluent-bit/scripts
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
{{- if .Values.hotReload.enabled }}
  - name: reloader
    image: {{ include "fluent-bit.image" .Values.hotReload.image }}
    args:
      - {{ printf "-webhook-url=http://localhost:%s/api/v2/reload" (toString .Values.metricsPort) }}
      - -volume-dir=/watch/config
      - -volume-dir=/watch/scripts
      {{- range $idx, $val := .Values.hotReload.extraWatchVolumes }}
      - {{ printf "-volume-dir=/watch/extra-%d" (int $idx) }}
      {{- end }}
    volumeMounts:
      - name: config
        mountPath: /watch/config
      - name: luascripts
        mountPath: /watch/scripts
      {{- range $idx, $val := .Values.hotReload.extraWatchVolumes }}
      - name: {{ $val }}
        mountPath: {{ printf "/watch/extra-%d" (int $idx) }}
      {{- end }}
    {{- with .Values.hotReload.resources }}
    resources:
      {{- toYaml . | nindent 12 }}
    {{- end }}
{{- end }}
{{- if .Values.extraContainers }}
  {{- if kindIs "string" .Values.extraContainers }}
    {{- tpl .Values.extraContainers $ | nindent 2 }}
  {{- else }}
    {{-  toYaml .Values.extraContainers | nindent 2 }}
  {{- end -}}
{{- end }}
volumes:
  - name: config
    configMap:
      name: {{ default (include "fluent-bit.fullname" .) .Values.existingConfigMap }}
{{- if or .Values.luaScripts .Values.hotReload.enabled }}
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
