from django.contrib.auth.models import User, Group
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse 
from rest_framework import viewsets
from rest_framework import permissions
from WebApp.models import Station
import requests
import json

def get_client_ip (request):
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

        station = Station.objects.get (uuid = station_uuid)

        if station:
            station.ip = ip_addr
            station.save()

            response = json.dumps ([{"uuid": str (station.uuid),
                                     "ip": station.ip}])
            return HttpResponse (response)
        else:
            return HttpResponse ("Invalid station UUID")

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
        payload = json.loads (request.body)
        station_uuid = payload['uuid']
        lock_id = payload['lock_id']

        station = Station.objects.get (uuid = station_uuid)

        r = requests.get (station.ip + ':8000/lock/' + lock_id)
        return HttpResponse ("Locked *thumbs up*")
    else:
        return HttpResponse ("Miss me with that GET")
