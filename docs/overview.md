# Fluent-bit

## Overview

This package contains an extensible and configurable installation of Fluent-bit based on the upstream chart provided by fluent.

## Fluent-bit

[Fluent Bit](https://fluentbit.io) is An open source Log Processor and Forwarder which allows you to collect any data like metrics and logs from different sources, enrich them with filters and send them to multiple destinations. It's the preferred choice for containerized environments like Kubernetes. Designed with performance in mind: high throughput with low CPU and Memory usage. It's written in C language and has a pluggable architecture supporting more than 70 extensions for inputs, filters and outputs. 

Fluent Bit is a CNCF (Cloud Native Computing Foundation) subproject under the umbrella of Fluentd.

## How it works

Fluent-bit mounts a hostPath volume at `/var/log` for each node in a cluster and the service tails each log it finds and sends to the configured output or set of outputs in the [values](../chart/values.yaml#L276). The default production setup of the package provided by Platform One is configured to use a [storage buffer](https://docs.fluentbit.io/manual/administration/buffering-and-storage#filesystem-buffering-to-the-rescue) to better keep track of the many logs a production kubernetes cluster will generate. The default output for fluent-bit within BigBang is Elasticsearch but fluent-bit has many [output plugins available](https://docs.fluentbit.io/manual/pipeline/outputs).

Please review the BigBang [Architecture Document](https://repo1.dso.mil/platform-one/big-bang/bigbang/-/blob/master/charter/packages/fluentbit/Architecture.md) for more information about it's role within BigBang.