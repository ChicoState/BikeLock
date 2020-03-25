from django.contrib.auth.models import User, Group
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse 
from django.core import exceptions
from rest_framework import viewsets
from rest_framework import permissions
from WebApp.models import Station
import requests
import json

def get_client_ip (request):
    """
    From this Stack Overflow post https://stackoverflow.com/questions/4581789/how-do-i-get-user-ip-address-in-django

    Solution by user yanchenko https://stackoverflow.com/users/15187/yanchenko
    """
    x_forwarded_for = request.META.get ('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip

@csrf_exempt
def StationView (request):
    if request.method == 'POST':
        payload = json.loads (request.body)
        station_uuid = payload['uuid']
        ip_addr = get_client_ip (request)

        response = ''

        try:
            station = Station.objects.get (uuid = station_uuid)
        except exceptions.ObjectDoesNotExist:
            return HttpResponse ("Invalid station UUID")

        station.ip = ip_addr
        station.save()

        response = json.dumps ([{"uuid": str (station.uuid),
                                 "ip": station.ip}])
        return HttpResponse (response)

    if request.method == 'GET':
        response = []
        stations = Station.objects.all()

        for station in stations:
            response.append ({"uuid": str (station.uuid),
                              "ip": station.ip})

        return HttpResponse (json.dumps (response))


@csrf_exempt
def LockStationView (request):
    if request.method == 'POST':
        # Get request parameters
        payload = json.loads (request.body)
        station_uuid = payload['uuid']
        lock_id = payload['lock_id']
        state = payload['state']

        try:
            station = Station.objects.get (uuid = station_uuid)
        except exceptions.ObjectDoesNotExist:
            return HttpResponse ("Invalid station UUID")

        url = 'http://' + station.ip + ':8000/lock/' + lock_id
        payload = {'state': state}

        r = requests.post (url, json=payload)

        if r.status_code == 200:
            return HttpResponse ("Locked *thumbs up*")
        else:
            return HttpResponse (f"Something went wrong. Status code {r.status_code}")
    else:
        return HttpResponse ("Miss me with that GET")
