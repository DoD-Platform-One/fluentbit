# Troubleshooting

## Fluentbit did not restart after Elasticsearch re-deployment/secret update.

If you are having issues with Fluentbit connectivity to Elastic (caused by an Elastic redeployment/cert update) you should be able to resolve them by restarting Fluentbit. For example, run the below to cycle all pods in the Fluentbit daemonset:
```bash
kubectl rollout restart daemonset/logging-fluent-bit -n logging
```

## Too many open files

In some environments you may see errors such as the one below:

```bash
fluent-bit [2022/07/05 16:20:10] [error] [build/plugins/in_tail/CMakeFiles/flb-plugin-in_tail.dir/compiler_depend.ts:304 errno=24] Too many open files
```

Currently the best way to resolve this issue is to update each of your nodes' number of inotify resources and file watches:

```bash
/proc/sys/fs/inotify/max_user_watches
/proc/sys/fs/inotify/max_user_instances
```

For example, BigBang testing environments have the following values set:

```bash
cat /proc/sys/fs/inotify/max_user_instances
1024
cat /proc/sys/fs/inotify/max_user_watches
1048576
```

You can update the limits temporarily, with the following commands (setting the values to 1024 and 1048576 respectively in this example):

```bash
sudo sysctl fs.inotify.max_user_instances=1024
sudo sysctl fs.inotify.max_user_watches=1048576
sudo sysctl -p
```

In order to make the changes permanent, i.e. to persist through a node reboot:

```bash
echo "fs.inotify.max_user_instances=1024" > /etc/sysctl.d/fs-inotify-max_user_instances.conf
sysctl -w fs.inotify.max_user_instances=1024
echo "fs.inotify.max_user_watches=1048576" > /etc/sysctl.d/fs-inotify-max_user_watches.conf
sysctl -w fs.inotify.max_user_watches=1048576
sysctl -p
```

Checkout https://github.com/fluent/fluent-bit/issues/1777#issuecomment-562178857 for more details

If updating the above does not help to resolve the issue you can test switching to stat watch for the input config. To do this set `Inotify_Watcher` to false, which can be done via the below values:

```yaml
config:
  inputs: |
    [INPUT]
        Name tail
        Path /var/log/containers/*.log
        # -- Excluding fluentbit logs from sending to ECK, along with gatekeeper-audit logs which are shipped by clusterAuditor.
        Exclude_Path /var/log/containers/*fluent*.log
        Parser containerd
        Tag kube.*
        Mem_Buf_Limit 50MB
        Skip_Long_Lines On
        storage.type filesystem
        Inotify_Watcher false

    [INPUT]
        Name systemd
        Tag host.*
        Systemd_Filter _SYSTEMD_UNIT=kubelet.service
        Read_From_Tail On
        storage.type filesystem
```

Additional details on this configuration value can be reviewed on the [tail plugin configuration](https://docs.fluentbit.io/manual/pipeline/inputs/tail) page. Note that there has been report of possible memory [issues](https://github.com/fluent/fluent-bit/issues/1777#issuecomment-828958525) with stat watcher. If using this method make sure you have an alert/adequate visibility into Fluentbit memory usage.
