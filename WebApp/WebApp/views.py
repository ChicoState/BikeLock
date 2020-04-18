from django.contrib.auth.models import User, Group
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse, HttpResponseForbidden, JsonResponse
from django.core import exceptions
from rest_framework import viewsets
from rest_framework import permissions
from WebApp.models import Station
import requests
import json
from datetime import datetime

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
            if not station.ip:
                continue

            url = 'http://' + station.ip + ':8000/summary/'

            try:
                r = requests.get (url)
            except requests.exceptions.ConnectionError:
                station.ip = ''
                station.save()
                continue

            payload = json.loads (r.text)
            payload['ip'] = station.ip

            response.append (payload)

        return HttpResponse (json.dumps(response))


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

        url = 'http://' + station.ip + ':8000/lock/'
        payload = {'lock_id': lock_id, 'state': state}

        try:
            r = requests.post (url, json=payload)
        except requests.exceptions.ConnectionError:
            station.ip = ''
            station.save()
            return HttpResponse (f"Something went wrong. Station is not up.", status=500)

        if r.status_code == 200:
            return HttpResponse ("Locked *thumbs up*")
        else:
            return HttpResponse (f"Something went wrong. Status code {r.status_code}", status=500)

    if request.method == 'GET':
        station_uuid = request.GET['uuid']
        lock_id = int(request.GET['lock_id'])

        try:
            station = Station.objects.get (uuid = station_uuid)
        except exceptions.ObjectDoesNotExist:
            return HttpResponse ("Invalid station UUID")

        if not station.ip:
            return HttpResponse (f"something went wrong. Station is not up.", status=500)

        url = 'http://' + station.ip + ':8000/lock/'
        payload = {'lock_id': lock_id}

        try:
            r = requests.get (url, json=payload)
        except requests.exceptions.ConnectionError:
            station.ip = ''
            station.save()
            return HttpResponse (f"Something went wrong. Station is not up.", status=500)

        payload = json.loads(r.text)

        if r.status_code == 200:
            return JsonResponse(payload)
        else:
            return HttpResponse (f"Something went wrong. Status code {r.status_code}", status=500)

@csrf_exempt
def CreateUserView (request):
    if request.method == 'POST':
        payload = json.loads (request.body)

        username = payload['username']
        password = payload['password']
        email = payload['email']
        date = datetime.now()

        try:
            User.objects.get (username=username)
            return JsonResponse ({"error": "username_taken"})
        except User.DoesNotExist:
            pass
        
        user = User.objects.create_user (username=username, 
                                         password=password, 
                                         email=email, 
                                         date_joined=date)

        return JsonResponse ({"username": username})
    else:
        return HttpResponseForbidden (['POST'])
