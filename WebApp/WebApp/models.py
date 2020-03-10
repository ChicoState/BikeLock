from django.db import models

class Station (models.Model):
    ip = models.GenericIPAddressField (protocol = 'IPv4', primary_key = True)

