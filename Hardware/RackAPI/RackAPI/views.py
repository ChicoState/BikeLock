from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse, JsonResponse
import lock
import json

@csrf_exempt
def setLock(request):
    if request.method == 'POST':
        payload = json.loads(request.body)
        lockid = payload['lock_id']

        lock.set_Lock_State(lockid,state)
        return JsonResponse(payload)
    
    if request.method == 'GET':
        payload = json.loads(request.body)
        lockid = payload['lock_id']
        payload['state'] = lock.get_Lock_State(lockid)

        return JsonResponse(payload)

