from django.db import models
from django.contrib.auth.models import User
from datetime import datetime
import uuid

class Station (models.Model):
    uuid = models.UUIDField (primary_key=True, default=uuid.uuid4, editable=False)
    ip = models.GenericIPAddressField (default='', blank=True, null=True)

"""
A Bike entry in the database stores information about a user's actively
reserved lock, such as the time the lock was reserved and the rate at
the time of reservation.
"""
class Bike (models.Model):
    user = models.ForeignKey (User, on_delete=models.PROTECT)
    station = models.ForeignKey (Station, on_delete=models.PROTECT)
    lockID = models.PositiveIntegerField()
    rate = models.DecimalField (max_digits=6, decimal_places=2)
    timeOfReservation = models.DateTimeField (auto_now_add=True)

    def timeElapsed (self):
        timeDelta = datetime.now() - self.timeOfReservation
        totalSeconds = timeDelta.total_seconds()
        m, s = divmod (totalSeconds, 60)
        h, m = divmod (totalSeconds, 60)

        return h, m, s
       
