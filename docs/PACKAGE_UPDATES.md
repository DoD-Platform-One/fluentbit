# Code Changes for Updates

Fluentbit within Big Bang is a modified version of an upstream chart. `kpt` is used to handle any automatic updates from upstream. The below details the steps required to update to a new version of the Fluentbit package.

1. Navigate to the upstream [fluentbit helm chart repo](https://github.com/fluent/helm-charts/tree/main/charts/fluent-bit) and find the latest chart version that works with the image update. For example, if updating to 1.8.11 I would look at the [Chart.yaml](https://github.com/fluent/helm-charts/blob/main/charts/fluent-bit/Chart.yaml) `appVersion` field and switch through the latest git tags until I find one that matches 1.8.11. For this example that would be [`fluent-bit-0.19.16`](https://github.com/fluent/helm-charts/blob/fluent-bit-0.19.16/charts/fluent-bit/Chart.yaml#L9).

2. From the top level of the repo run `kpt pkg update chart@{GIT TAG} --strategy alpha-git-patch` replacing `{GIT TAG}` with the tag you found in step one. You may run into some merge conflicts, resolve these in the way that makes the most sense. In general, if something is a BB addition you will want to keep it, otherwise go with the upstream change.

3. Append `-bb.0` to the `version` in `chart/Chart.yaml`.

4. Update `CHANGELOG.md` adding an entry for the new version and noting all changes (at minimum should include `Updated Fluentbit to x.x.x`).

5. Generate the `README.md` updates by following the [guide in gluon](https://repo1.dso.mil/platform-one/big-bang/apps/library-charts/gluon/-/blob/master/docs/bb-package-readme.md).

6. Open an MR in "Draft" status and validate that CI passes. This will perform a number of smoke tests against the package, but it is good to manually deploy to test some things that CI doesn't. Follow the steps below for manual testing.

7. Once all manual testing is complete take your MR out of "Draft" status and add the review label.

# Manual Testing for Updates

NOTE: For these testing steps it is good to do them on both a clean install and an upgrade. For clean install, point fluentbit to your branch. For an upgrade do an install with fluentbit pointing to the latest tag, then perform a helm upgrade with fluentbit pointing to your branch.

You will want to install with:
- ECK Operator, Logging, and Fluentbit enabled
- Istio enabled
- Monitoring enabled

Testing Steps:
- Login to Prometheus, validate under `Status` -> `Targets` that all fluentbit targets are showing as up
- Login to Grafana, then navigate to https://grafana.bigbang.dev/d/logging-fluent-bit/logging-fluent-bit and validate that the dashboard displays data
- Login to Kibana, then navigate to https://kibana.bigbang.dev/app/management/kibana/indexPatterns and add an index pattern for `logstash-*`
- Navigate to `Analytics` -> `Discover` and validate that pod logs are appearing in the `logstash` index pattern

When in doubt with any testing or upgrade steps ask one of the CODEOWNERS for assistance.
