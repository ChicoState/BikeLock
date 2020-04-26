from django.test import TestCase, Client
from WebApp.models import Station
import json

class StationViewTestCase (TestCase):
    """
    All things /api/stations
    """
    def setUp (self):
        Station.objects.create ()
        
    def test_getRequest (self):
        """
        Just a GET
        """
        c = Client()
        response = c.get ('/api/stations/')

        # Verify correct response code
        self.assertEqual (response.status_code, 200)

    def test_postRequest (self):
        """
        Update an existing station with a new IP address
        """
        c = Client()
        uuid = Station.objects.all()[0].uuid
        payload = {
	    'uuid': str (uuid)
        }
        response = c.post ('/api/stations/', json.dumps (payload), content_type='application/json')
        station = Station.objects.get (uuid=uuid)

        # Verify station IP address has changed
        self.assertNotEqual (station.ip, '')

        # Verify correct response code (200)
        self.assertEqual (response.status_code, 200)


    def test_invalidUUID (self):
        """
        POST with an invalid UUID
        """
        c = Client()
        invalidUUID = 'haha jk'
        payload = {
            'uuid': invalidUUID
        }
        response = c.post ('/api/stations/', json.dumps (payload), content_type='application/json')

        # Verify correct response code (400)
        self.assertEqual (response.status_code, 400)

