import RPi.GPIO as GPIO
import time

ledpins = [23,24]

def init():
    for pin in ledpins:
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(pin, GPIO.OUT)

def get_Lock_Count():
    return len(ledpins)

def set_Lock_State(lockid, state):
    GPIO.output(ledpins[lockid], state)

def get_Lock_State(lockid = -1):
    if lockid == -1:
        states = []
        for pin in range(get_Lock_Count()):
            states.append(get_Lock_State(pin))
        return states
    return GPIO.input(ledpins[lockid])
