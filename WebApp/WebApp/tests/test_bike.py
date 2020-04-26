from django.test import TestCase
from WebApp.models import Bike, Station
from django.contrib.auth.models import User
import time

class BikeTestCase (TestCase):
    def setUp (self):
        User.objects.create (username="user", password="pass")
        Station.objects.create()
        Bike.objects.create (user = User.objects.first(),
                             station = Station.objects.first(),
                             lockID = 0,
                             rate = 1.5)

    def test_timeElapsed (self):
        bike = Bike.objects.first()
        h, m, s = bike.timeElapsed()
        self.assertTrue (any(x != 0 for x in [h, m, s]))
        
