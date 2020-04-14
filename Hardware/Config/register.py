import requests
import time

LOGIN_URL = 'http://rackServer:8000/api/stations/'

def registerRack(uuid):
    while True:
        time.sleep(5)

        try:
            r = requests.post(LOGIN_URL, json={'uuid':uuid})
        except requests.exceptions.ConnectionError:
            continue

        if r.status_code == 200:
            return

