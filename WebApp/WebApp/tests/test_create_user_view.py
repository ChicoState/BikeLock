from django.test import TestCase, Client
from WebApp.models import Bike, User, Station
import json

class CreateUserViewTestCase (TestCase):
    def setUp (self):
        self.dummy_username = 'user@user.com'
        self.dummy_email = 'user@user.com'
        self.dummy_password = 'password'

    def test_newUser (self):
        c = Client()
        payload = {
            'username': self.dummy_username,
            'email': self.dummy_email,
            'password': self.dummy_password 
        }

        response = c.post ('/api/create-user/', json.dumps (payload), content_type='application/json')
        self.assertEqual (response.json()['username'], self.dummy_username);

    def test_usernameTaken (self):
        c = Client()
        payload = {
            'username': self.dummy_username,
            'email': self.dummy_email,
            'password': self.dummy_password
        }
        response = c.post ('/api/create-user/', json.dumps (payload), content_type='application/json')

        payload = {
            'username': self.dummy_username,
            'email': self.dummy_email,
            'password': self.dummy_password
        }
        response = c.post ('/api/create-user/', json.dumps (payload), content_type='application/json')

        self.assertEqual (response.json()['error'], 'username_taken')
