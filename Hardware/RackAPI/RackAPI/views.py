from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse, JsonResponse
import lock
import json

@csrf_exempt
def setLock(request):
    if request.method == 'POST':
        payload = json.loads(request.body)
        state = payload['state']
        lockid = payload['lock_id']

        lock.set_Lock_State(lockid,state)
        return JsonResponse(payload)
    
    if request.method == 'GET':
        return HttpResponse('Who uses GET?')

