from django.http import JsonResponse
import lock

def setLock(request, state):
    lock.set_Lock_State(0,state)
    data = {
        'state': state,
        'stationID': 42,
        'lockID': 3,
    }
    return JsonResponse(data)
