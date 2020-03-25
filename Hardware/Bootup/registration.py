import requests
from sys import stdin

vals = {}

for line in stdin:
    if line == '\n': continue
    key, val = line.split()
    key = key[:-1]
    vals[key] = val

if 'uuid' not in vals:
    print('error: UUID not specified')
    quit()

uuid = vals['uuid']

LOGIN_URL = 'http://rackServer:8000/api/stations/'
r = requests.post(LOGIN_URL, json=vals)#headers={'X-CSRFToken':csrftoken})
print(r.text)


