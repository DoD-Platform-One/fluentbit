# Code Changes for Updates

Fluentbit within Big Bang is a modified version of an upstream chart. `kpt` is used to handle any automatic updates from upstream. The below details the steps required to update to a new version of the fluentbit package.

1. Navigate to the upstream [fluentbit helm chart repo](https://github.com/fluent/helm-charts/tree/main/charts/fluent-bit) and find the latest chart version that works with the image update. For example, if updating to 1.8.11 I would look at the [Chart.yaml](https://github.com/fluent/helm-charts/blob/main/charts/fluent-bit/Chart.yaml) `appVersion` field and switch through the latest git tags until I find one that matches 1.8.11. For this example that would be [`fluent-bit-0.19.16`](https://github.com/fluent/helm-charts/blob/fluent-bit-0.19.16/charts/fluent-bit/Chart.yaml#L9).

2. From the top level of the repo run `kpt pkg update chart@{GIT TAG} --strategy alpha-git-patch` replacing `{GIT TAG}` with the tag you found in step one. You may run into some merge conflicts, resolve these in the way that makes the most sense. In general, if something is a BB addition you will want to keep it, otherwise go with the upstream change.

3. Append `-bb.0` to the `version` in `chart/Chart.yaml`.

4. Update dependencies and binaries using `helm dependency update ./chart`

    - Pull assets and commit the binaries as well as the Chart.lock file that was generated.
      ```shell
      helm dependency update ./chart
      ```

5. Update `CHANGELOG.md` adding an entry for the new version and noting all changes (at minimum should include `Updated fluentbit to x.x.x`).

6. Generate the `README.md` updates by following the [guide in gluon](https://repo1.dso.mil/platform-one/big-bang/apps/library-charts/gluon/-/blob/master/docs/bb-package-readme.md).

7. (_Optional, only required if package changes are expected to have cascading effects on bigbang umbrella chart_) As part of your MR that modifies bigbang packages, you should modify the bigbang [bigbang/tests/test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads) against your branch for the CI/CD MR testing by enabling your packages.

    - To do this, at a minimum, you will need to follow the instructions at [bigbang/docs/developer/test-package-against-bb.md](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/developer/test-package-against-bb.md?ref_type=heads) with changes for fluentbit enabled (the below is a reference, actual changes could be more depending on what changes where made to fluentbit in the package MR).

### [test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads)
```yaml
fluentbit:
  enabled: true
  git:
    tag: null
    branch: renovate/ironbank
  values:
    istio:
      hardened:
        enabled: true
  ### Additional components of fluentbit should be changed to reflect testing changes introduced in the package MR
```

8. Once all manual testing is complete take your MR out of "Draft" status and add the review label.

# Manual Testing for Updates

>NOTE: For these testing steps it is good to do them on both a clean install and an upgrade. For clean install, point fluentbit to your branch. For an upgrade do an install with fluentbit pointing to the latest tag, then perform a helm upgrade with fluentbit pointing to your branch.

The following overrides can be used for a bare minimum fluentbit deployment:

```yaml
elasticsearchKibana:
  enabled: true
  sso:
    enabled: true
    client_id: platform1_a8604cc9-f5e9-4656-802d-d05624370245_bb8-kibana
  values:
    istio:
      enabled: true
      hardened:
        enabled: true

eckOperator:
  enabled: true

kyverno:
  enabled: true

kyvernoPolicies:
  enabled: true
  values:
    policies:
      restrict-host-path-mount-pv:
        parameters:
          allow:
          - /var/lib/rancher/k3s/storage/pvc-*

istio:
  enabled: true
  values:
    hardened:
      enabled: true

fluentbit: 
  enabled: true
  git:
    tag: null
    branch: renovate/ironbank
  values:
    istio:
      enabled: true
      hardened:
        enabled: true

monitoring:
  enabled: true
  values:
    istio:
      enabled: true
      hardened:
        enabled: true

loki:
  enabled: true
  values:
    istio:
      enabled: true
      hardened:
        enabled: true

promtail:
  enabled: false
  values:
    istio:
      enabled: true
      hardened:
        enabled: true

neuvector:
  enabled: false

grafana:
  enabled: true
  values:
    istio:
      enabled: true
      hardened:
        enabled: true
```

The following is an example of how to run fluentbit with operatorless istio:
```yaml
######### Istio Operator-less (istioCore) Overrides #############
networkPolicies:
  enabled: true

istio:
  enabled: false

istioOperator:
  enabled: false

istioCRDs:
  enabled: true

istiod:
  enabled: true

istioGateway:
  enabled: true 

######### Additional Overrides ###########
# sso:
#   # This is needed because test-values.yaml overrides it to reference the internal keycloak
#   url: https://login.dso.mil/auth/realms/baby-yoda
elasticsearchKibana:
  enabled: true
  sso:
    enabled: true
    client_id: platform1_a8604cc9-f5e9-4656-802d-d05624370245_bb8-kibana

eckOperator:
  enabled: true

fluentbit: 
  enabled: true
  git:
    tag: null
    branch: renovate/ironbank

monitoring:
  enabled: true

loki:
  enabled: true

grafana:
  enabled: true

neuvector:
  enabled: false
```

Testing Steps:
- Login to [Prometheus](https://prometheus.dev.bigbang.mil/), validate under `Status` -> `Targets` that all fluentbit targets are showing as up
- Login to [Grafana](https://grafana.dev.bigbang.mil/), then navigate to `Dashboards` > `fluentbit-fluent-bit` and validate that the dashboard displays data
- Login to [Kibana](https://kibana.dev.bigbang.mil/), then navigate to https://kibana.dev.bigbang.mil/app/management/kibana/indexPatterns and create a data view for `logstash-*`
  - Navigate to `Analytics` -> `Discover` and validate that pod logs are appearing in the `logstash` index pattern

Note: as of BB 2.0, if kyverno is not enabled in your cluster the following secrets will need to be copied from the logging namespace to fluentbit in order to successfully test fluentbit log shipping to elasticsearch.
- `logging-ek-es-http-certs-public`
- `logging-ek-es-http-certs-internal`
- `logging-ek-es-elastic-user`

The following script can be run to copy the secrets over from the logging namespace. The `yq` package install instructions can be found [here](https://mikefarah.gitbook.io/yq/).

```bash
kubectl get secret -n logging logging-ek-es-http-certs-public -o yaml | yq '.metadata.namespace = "fluentbit"' - | kubectl apply -f -

kubectl get secret -n logging logging-ek-es-http-certs-internal -o yaml | yq 'del(.metadata["creationTimestamp","resourceVersion","selfLink","uid","ownerReferences"])' | yq '.metadata.namespace = "fluentbit"' - | kubectl apply -f -

kubectl get secret -n logging logging-ek-es-elastic-user -o yaml | yq '.metadata.namespace = "fluentbit"' - | kubectl apply -f -
```

When in doubt with any testing or upgrade steps ask one of the CODEOWNERS for assistance.

# Modifications made to upstream chart

Note that this list is likely incomplete currently.

## chart/templates/configmap.yaml

- Added `fluent-bit.conf:` configuration

## chart/templates/_pod.tpl

- Changed container name to `name: {{ default .Chart.Name .Values.nameOverride }}`
- Added `additionalOutputs` definitions and configs to `envFrom`
- Added `additionalOutputs` ca-certs to `volumeMounts` and `volumes`

## chart/values.yaml

- Added values for `elasticsearch`, `istio`, `additionalOutputs`, `storage_buffer`, `networkPolicies`, `openshift`, and `bbtests`
- Changed default image source to Ironbank / Registry1
- Set default `securityContext`, `imagePullSecrets`, `extraVolumes`, `extraVolumeMounts`, and `config`
- Added commented out values for `serviceMonitor.scheme` and `serviceMonitor.tlsConfig`

## chart/Chart.yaml

- Name changed to `fluentbit`
- Annotations added for application and image versioning
- Gluon dependency added for helm tests
