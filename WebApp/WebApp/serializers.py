from django.contrib.auth.models import User, Group
from rest_framework import serializers
from WebApp.models import Station

class StationSerializer (serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Station
        fields = ['uuid', 'ip']

