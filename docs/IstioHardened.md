# Istio Configuration (bb-common)
Fluentbit now uses the `bb-common` library chart to render Istio resources when
`.Values.istio.enabled` is `true`. This document summarizes the supported
Istio settings and replaces the deprecated `istio.hardened.*` values.

## Prerequisites
Istio resources are only rendered when `.Values.istio.enabled: true`. If there
are no Istio proxies in the namespace, Istio resources will not affect traffic.

## Sidecar (Outbound Traffic Policy)
Enable the Sidecar and set the outbound traffic policy mode:

```yaml
istio:
  enabled: true
  sidecar:
    enabled: true
    outboundTrafficPolicyMode: REGISTRY_ONLY # or ALLOW_ANY
```

## ServiceEntries
Custom ServiceEntries are supported via `istio.serviceEntries.custom`:

```yaml
istio:
  enabled: true
  serviceEntries:
    custom:
      - name: "allow-google"
        spec:
          hosts:
            - google.com
          location: MESH_EXTERNAL
          ports:
            - number: 443
              protocol: TLS
              name: https
          resolution: DNS
```

## Authorization Policies
AuthorizationPolicies can be enabled and customized via bb-common:

```yaml
istio:
  enabled: true
  authorizationPolicies:
    enabled: true
    generateFromNetpol: false
    custom:
      - name: "allow-my-namespace"
        spec:
          selector:
            matchLabels:
              app.kubernetes.io/name: "server-app"
          action: ALLOW
          rules:
            - from:
                - source:
                    namespaces:
                      - "my-namespace"
```

When `generateFromNetpol: true`, bb-common will create AuthorizationPolicies
from `networkPolicies.ingress` rules (requires Istio + mTLS).

## PeerAuthentication
PeerAuthentication is rendered as a namespace default when Istio is enabled.
Control mTLS mode with:

```yaml
istio:
  enabled: true
  mtls:
    mode: STRICT
```
