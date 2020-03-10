from django.contrib.auth.models import User, Group
from rest_framework import viewsets
from rest_framework import permissions
from WebApp.serializers import StationSerializer
from WebApp.models import Station

class StationViewSet (viewsets.ModelViewSet):
    """
    API endpoint that allows stations to be viewed or edited
    """
    queryset = Station.objects.all()
    serializer_class = StationSerializer

