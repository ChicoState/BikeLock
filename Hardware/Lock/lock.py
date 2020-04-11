import RPi.GPIO as GPIO
import time

ledpins = [23,24]

def init():
    for pin in ledpins:
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(pin, GPIO.OUT)

def set_Lock_State(lockid, state):
    GPIO.output(ledpins[lockid], state)

def get_Lock_State(lockid):
    return GPIO.input(ledpins[lockid])

def get_Lock_count():
    return len(ledpins)
