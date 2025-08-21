# Config

## How did I make these configs

- cilium.config: referenced [Cilium - System Requirements](https://docs.cilium.io/en/latest/operations/system_requirements/).
- istio.config: referenced a related issue to using Wireshark in WSL2 somewhere.

Bash brace expansion syntax is supported:

```
CONFIG_INET{,6}_ESP=m
```

which expands to

```
CONFIG_INET_ESP=m
CONFIG_INET6_ESP=m
```
