#  Increase (or decrease) the number of indexes that are generated

If Elasticsearch indexes (by default 1 logstash-XX index per day) are too large, one can follow this linux string time formatting logic to increase (or decrease) the number of indexes that are generated: [strftime](https://man7.org/linux/man-pages/man3/strftime.3.html)

For example, inside the outputs configuration values section you will need to define `Logstash_DateFormat`. For example to generate a new index for each hour of the day the configuration would be `Logstash_DateFormat %Y.%m.%d-%k` while 2 indexes per day would be `Logstash_DateFormat %Y.%m.%d-%P`.

Below is the elasticsearch output specific information for fluentbit:
[es output plugin](https://docs.fluentbit.io/manual/pipeline/outputs/elasticsearch)

> **Note:** These values must be nested under `upstream:` as this chart wraps the upstream fluent-bit Helm chart.

### Example

```yaml
upstream:
  config:
    outputs: |
      [OUTPUT]
          Name es
          Match kube.*
          # -- Pointing to Elasticsearch service installed by ECK, based off EK name "logging-ek", update elasticsearch.name above to update.
          Host {{ .Values.elasticsearch.name }}-es-http
          HTTP_User elastic
          HTTP_Passwd ${FLUENT_ELASTICSEARCH_PASSWORD}
          Logstash_Format On
          # generate a new index for each hour of the day
          Logstash_DateFormat %Y.%m.%d-%k
          Retry_Limit False
          Replace_Dots On
          tls On
          tls.verify On
          tls.ca_file /etc/elasticsearch/certs/ca.crt
          storage.total_limit_size {{ .Values.storage.total_limit_size }}
```