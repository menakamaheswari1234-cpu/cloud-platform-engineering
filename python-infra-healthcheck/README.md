# Python Infra Healthcheck

![ci](https://github.com/menakamaheswari1234-cpu/python-infra-healthcheck/actions/workflows/ci.yml/badge.svg)

A small, dependency-free CLI that checks HTTP endpoints and returns JSON plus a meaningful exit code, so it drops into cron, Jenkins stages or Kubernetes CronJobs. A reference implementation of the health-check automation I use to cut manual operational effort.

```bash
python healthcheck.py https://example.com https://example.com/healthz --timeout 3
# exit code 0 = all healthy, 1 = at least one failed
```

Output includes status code, latency in ms, and the error for unreachable hosts. Tests spin up a local HTTP server (healthy, unhealthy and unreachable cases) and run in GitHub Actions.
