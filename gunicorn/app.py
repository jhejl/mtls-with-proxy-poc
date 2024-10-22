#!/usr/bin/env python3

import os
import requests
from flask import Flask

app = Flask(__name__)

# Give more respect to ENV variables
proxies = {
   'http': os.environ.get('HTTP_PROXY'),
   'https': os.environ.get('HTTPS_PROXY')
}

cert_path = os.environ.get('CLIENT_CERT_PATH')
key_path = os.environ.get('CLIENT_KEY_PATH')
cacert = os.environ.get('CLIENT_CACERT')


@app.route("/")
def mtls_client():
    url = os.environ.get('REMOTE_ENDPOINT_URL')
    response = requests.get(
        url,
        proxies=proxies,
        cert=(cert_path, key_path),
        verify=False,
    )
    return response.content
