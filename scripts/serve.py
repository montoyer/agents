#!/usr/bin/env python3
"""Serve the site/ directory on port 8080."""
import http.server
import os

os.chdir(os.path.join(os.path.dirname(__file__), "..", "site"))
http.server.test(HandlerClass=http.server.SimpleHTTPRequestHandler, port=8080)
