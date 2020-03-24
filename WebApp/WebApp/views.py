from django.contrib.auth.models import User, Group
from django.http import HttpResponse 
from rest_framework import viewsets
from rest_framework import permissions
from WebApp.serializers import StationSerializer
from WebApp.models import Station
import requests
import json

class StationViewSet (viewsets.ModelViewSet):
    """
    API endpoint that allows stations to be viewed or edited
    """
    queryset = Station.objects.all()
    serializer_class = StationSerializer


def LockStationView (request):
    if request.method == 'POST':
        payload = json.loads (requests.body)
        staiton_uuid = payload['uuid']
        lock_id = payload['lock_id']

        station = Station.objects.get (uuid = station_uuid)

        r = requests.get (station.ip + 'api path stuff (lock_id)')
        return HttpResponse ("Locked *thumbs up*")
    else:
        return HttpResponse ("Miss me with that GET")
