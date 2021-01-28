# fluent-bit

Fluent-bit log shipper.  Deploys as a `DaemonSet` and ships explicitly to elasticsearch.  Future effort _may_ involve additional log data stores.

## Pre-Requisites

An elasticsearch cluster must be running in order for the `DaemonSet` to become healthy.  You can use [BigBang](https://repo1.dso.mil/platform-one/big-bang/umbrella) or the standalone [Elasticsearch](https://repo1.dso.mil/platform-one/big-bang/apps/core/elasticsearch-kibana) chart.

## Iron Bank

You can `pull` the registry1 image(s) [here](https://registry1.dso.mil/harbor/projects/3/repositories/opensource%2Ffluent%2Ffluent-bit) and view the container approval [here](https://ironbank.dso.mil/ironbank/repomap/opensource/fluent).