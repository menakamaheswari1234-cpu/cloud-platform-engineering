import threading
from http.server import BaseHTTPRequestHandler, HTTPServer

import healthcheck


class H(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200 if self.path == "/ok" else 503)
        self.end_headers()

    def log_message(self, *a):
        pass


def _server():
    s = HTTPServer(("127.0.0.1", 0), H)
    threading.Thread(target=s.serve_forever, daemon=True).start()
    return s


def test_healthy_endpoint():
    s = _server()
    r = healthcheck.check(f"http://127.0.0.1:{s.server_port}/ok")
    s.shutdown()
    assert r["ok"] and r["status"] == 200


def test_unhealthy_endpoint():
    s = _server()
    r = healthcheck.check(f"http://127.0.0.1:{s.server_port}/bad")
    s.shutdown()
    assert not r["ok"] and r["status"] == 503


def test_unreachable_host():
    r = healthcheck.check("http://127.0.0.1:1", timeout=1)
    assert not r["ok"] and r["error"]
