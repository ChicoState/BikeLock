from django.test import TestCase, Client
from WebApp.models import Bike, User, Station

class StatusViewTestCase (TestCase):
    def setUp (self):
        User.objects.create (username='test_user@test.com', email='test_user@test.com', password='pass')
        Station.objects.create()
        self.user = User.objects.first()
        self.station = Station.objects.first()
        Bike.objects.create (user=self.user, station=self.station, lockID=0, rate=1.0)
    
    def test_getRequestNotLoggedIn (self):
        c = Client()
        response = c.get ('/api/status/')

        self.assertEqual (response.status_code, 401)
        
