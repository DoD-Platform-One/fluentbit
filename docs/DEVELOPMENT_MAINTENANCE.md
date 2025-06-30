# Fluentbit Development and Maintenance Guide

## To Update the Fluentbit Package
**NOTE:** The fluentbit chart has been converted to the passthrough pattern and no longer uses `kpt`.

1. Navigate to the upstream [fluentbit helm chart repo](https://github.com/fluent/helm-charts/tree/main/charts/fluent-bit) and find the latest chart version that works with the current major version of the associated Iron Bank image. For example, if updating to 1.8.11 I would look at the [Chart.yaml](https://github.com/fluent/helm-charts/blob/main/charts/fluent-bit/Chart.yaml) `appVersion` field and switch through the latest git tags until I find one that matches 1.x.y.

2. `git clone` the [fluentbit repository](https://repo1.dso.mil/big-bang/product/packages/fluentbit) from Repo1 and checkout the `renovate/ironbank` branch.

3. Update the chart version in `./chart/Chart.yaml` and append or bump the `-bb.0` suffix (if missing or incorrect) to the chart version from upstream.

4. Ensure the Big Bang `./chart/Chart.yaml` and the target upstream version `Chart.yaml` align correctly with the following:
    - Check `appVersion` and `bigbang.dev/applicationVersions` in `./chart/Chart.yaml` to make sure they match and have updated to the correct version
    - Check the upstream chart dependencies and compare the dependency versions against the corresponding image tags in `./chart/values.yaml` to make sure they match

    **NOTE:** The Renovate issue may be blocked by one of the following conditions:
    - The upstream chart expects a newer image tag that does not yet exist in Iron Bank
      - If so, ensure that an issue exists in the associated Iron Bank container repository to track the upgrade version. Link the Iron Bank issue to the package Renovate issue for tracking purposes.
    - There is a newer image tag in Iron Bank, but is not yet supported or tested by upstream
    - If the newer image is a [major version](https://semver.org/) bump and/or contains breaking changes, the Renovate issue can be moved to `status::blocked` until the upstream chart catches up. If the newer image is only [a *patch* or *minor* version](https://semver.org/) bump, you can proceed with the Renovate (upgrading the image beyond the version referenced in the upstream chart).

5. Update `upstream.image.tag` in `./chart/values.yaml` to match the updated version in Iron Bank.

6. Update the `helm.sh/images` annotations in `./chart/Chart.yaml` to match updated versions in Iron Bank.

7. Update dependencies and binaries using `helm dependency update ./chart`.

8. Update `CHANGELOG.md` adding an entry for the new version and noting all changes (at minimum should include `Updated fluentbit to x.x.x`).

9. Generate the `README.md` updates by following the [guide in gluon](https://repo1.dso.mil/platform-one/big-bang/apps/library-charts/gluon/-/blob/master/docs/bb-package-readme.md).

10. (_Optional, only required if package changes are expected to have cascading effects on bigbang umbrella chart_) As part of your MR that modifies bigbang packages, you should modify the bigbang [bigbang/tests/test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads) to target your branch for CI/CD MR testing.

    - To do this, at a minimum, you will need to follow the instructions at [bigbang/docs/developer/test-package-against-bb.md](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/developer/test-package-against-bb.md?ref_type=heads) with changes for fluentbit enabled (the below is a reference, actual changes could be more depending on what changes where made to fluentbit in the package MR).

    **[test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads)**
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

11. Complete the manual testing steps in the following section.

12. Once all manual testing is complete, take your MR out of "Draft" status, assign reviewers, and add the review label.

## Manual Testing for Updates

>NOTE: For these testing steps it is good to do them on both a clean install and an upgrade. For clean install, point fluentbit to your branch. For an upgrade do an install with fluentbit pointing to the latest tag, then perform a helm upgrade with fluentbit pointing to your branch.

`overrides/fluentbit.yaml`
```yaml
######### Istio Operator-less (istioCore) Overrides #############
networkPolicies:
  enabled: true

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

bbctl:
  enabled: false

grafana:
  enabled: true

neuvector:
  enabled: false
```

Testing Steps:
- Login to [Prometheus](https://prometheus.dev.bigbang.mil/), validate under `Status` -> `Targets` that all fluentbit targets are showing as up
- Login to [Grafana](https://grafana.dev.bigbang.mil/), then navigate to `Dashboards` -> `fluentbit-fluent-bit` and validate that the dashboard displays data
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

When in doubt with any testing or upgrade steps ask one of the [CODEOWNERS](https://repo1.dso.mil/big-bang/product/packages/fluentbit/-/blob/main/CODEOWNERS) for assistance.