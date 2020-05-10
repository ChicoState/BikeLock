from django.test import TestCase, Client
from WebApp.models import Bike, User, Station
from rest_framework.authtoken.models import Token

class StatusViewTestCase (TestCase):
    def setUp (self):
        User.objects.create_user (username='test@test.com', email='test@test.com', password='test')
        Station.objects.create()
        self.user = User.objects.first()
        self.station = Station.objects.first()
        Token.objects.create (user_id=self.user.id)
        Bike.objects.create (user=self.user, station=self.station, lockID=0, rate=1.0)
    
    def test_getRequestNotAuthenticated (self):
        c = Client()
        response = c.get ('/api/status/')

        self.assertEqual (response.status_code, 401)

