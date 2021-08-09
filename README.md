# fluent-bit

Fluent-bit log shipper.  Deploys as a `DaemonSet` and ships explicitly to elasticsearch.  Future effort _may_ involve additional log data stores.

## Pre-Requisites

An elasticsearch cluster must be running in order for the `DaemonSet` to become healthy.  You can use [BigBang](https://repo1.dso.mil/platform-one/big-bang/umbrella) or the standalone [Elasticsearch](https://repo1.dso.mil/platform-one/big-bang/apps/core/elasticsearch-kibana) chart.

## Iron Bank

You can `pull` the registry1 image(s) [here](https://registry1.dso.mil/harbor/projects/3/repositories/opensource%2Ffluent%2Ffluent-bit) and view the container approval [here](https://ironbank.dso.mil/ironbank/repomap/opensource/fluent).

## Work-Arounds for Known Issues

There is a secret that FluentBit relies on from upstream at the eck-operator, that is `logging-ek-es-elastic-user` in the `logging` namespace.  Because the [helm controller in flux](https://github.com/fluxcd/helm-controller/issues/186) will not change to the new secret you must force reconcilation.  The operator must disable FluentBit in BigBang deploy, and renable FluentBit in BigBang and deploy again for the Pods to be updated by flux.  Otherwise manually removing the Pods controlled by the DaemonSet should acheive the same result.
