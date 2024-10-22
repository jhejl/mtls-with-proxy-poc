import requests

# NOTE: This is just a piece of code used for manual testing
#  it's not important as same logic is implemented in Gunicorn app

proxies = {
   'http': 'http://localhost:3128',
   'https': 'http://localhost:3128'
}

cert_path = 'client/client.crt'
key_path = 'client/client.key'
cacert = 'client/ca.crt'

url = 'https://server'
response = requests.get(
    url,
    proxies=proxies,
    cert=(cert_path, key_path),
    verify=False,
)
print(response.content)
