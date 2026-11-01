#!/usr/bin/env python3
"""Lightweight endpoint health checker for infra/ops use (stdlib only)."""
import argparse
import json
import sys
import time
import urllib.error
import urllib.request


def check(url: str, timeout: float = 5.0, expect: int = 200) -> dict:
    start = time.monotonic()
    try:
        with urllib.request.urlopen(url, timeout=timeout) as resp:
            status = resp.status
    except urllib.error.HTTPError as e:
        status = e.code
    except Exception as e:  # DNS failure, timeout, refused, TLS...
        return {"url": url, "ok": False, "status": None, "error": str(e),
                "latency_ms": round((time.monotonic() - start) * 1000, 1)}
    return {"url": url, "ok": status == expect, "status": status, "error": None,
            "latency_ms": round((time.monotonic() - start) * 1000, 1)}


def main(argv=None) -> int:
    p = argparse.ArgumentParser(description="Check HTTP endpoints; exit 1 if any fail.")
    p.add_argument("urls", nargs="+")
    p.add_argument("--timeout", type=float, default=5.0)
    p.add_argument("--expect", type=int, default=200)
    args = p.parse_args(argv)

    results = [check(u, args.timeout, args.expect) for u in args.urls]
    print(json.dumps(results, indent=2))
    return 0 if all(r["ok"] for r in results) else 1


if __name__ == "__main__":
    sys.exit(main())
