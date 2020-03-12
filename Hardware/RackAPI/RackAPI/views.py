from django.http import JsonResponse
import lock

def setLock(request, lockid, state):
    lock.set_Lock_State(lockid,state)
    data = {
        'state': state,
        'stationID': 42,
        'lockID': 3,
    }
    return JsonResponse(data)
