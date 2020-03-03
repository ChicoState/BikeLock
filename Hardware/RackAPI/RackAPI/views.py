from django.http import JsonResponse
import RPi.GPIO as GPIO

ledPin = 23

def lock(request, state):
    GPIO.output(ledPin, state)
    data = {
        'state': state,
        'stationID': 42,
        'lockID': 3,
    }
    return JsonResponse(data)
