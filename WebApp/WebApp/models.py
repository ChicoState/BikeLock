from django.db import models
from django.contrib.auth.models import User
import uuid

class Station (models.Model):
    uuid = models.UUIDField (primary_key=True, default=uuid.uuid4, editable=False)
    ip = models.GenericIPAddressField (default='', blank=True, null=True)

class Bike (models.Model):
    user = models.ForeignKey (User, on_delete=models.PROTECT)
    timestamp = models.DateTimeField (auto_now_add=True)
    rate = models.DecimalField (max_digits=6, decimal_places=2)

