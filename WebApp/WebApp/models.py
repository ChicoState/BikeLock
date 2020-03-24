import uuid
from django.db import models

class Station (models.Model):
    uuid = models.UUIDField (primary_key=True, default=uuid.uuid4, editable=False)
    ip = models.GenericIPAddressField (default='', blank=True, null=True)

