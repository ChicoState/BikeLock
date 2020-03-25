from django.contrib.auth.models import User, Group
from django.views.decorators.csrf import csrf_exempt
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
