import requests

def registerRack(uuid):
    LOGIN_URL = 'http://rackServer:8000/api/stations/'
    r = requests.post(LOGIN_URL, json={'uuid':uuid})

