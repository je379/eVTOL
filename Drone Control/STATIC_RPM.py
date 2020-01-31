from __future__ import print_function
from ADCPi import ADCPi
from hx711 import HX711
import RPi.GPIO as GPIO
import numpy as np
import time
import sys

class RPM:
    def __init__(self, signalpin):
        self.outpin = signalpin

        GPIO.setmode(GPIO.BCM)
        GPIO.setup(self.outpin, GPIO.IN)

    def count_rate(self, timeout=5):
        print(" ")
        print(" ")
        print("Getting sample rate...")
        print("### PLEASE WAIT ###")
        
        start = time.time()
        n = 0
        elapsed = time.time() - start

        while elapsed < timeout:
            x = self.get_state()
            n += 1
            elapsed = time.time()-start
        
        final = time.time() - start
        readpersec = n/final

        return readpersec

    def get_state(self):
        return GPIO.input(self.outpin)

    def get_rpm(self, readings=10, lowcount=30):
        thresh = readings-1     # Number of readings to average
        r = 0                   # Count number of revolutions
        av = 0                  # Average number of revs (in 10)
        rpmav = np.array([0,0,0,0,0,0,0,0,0,0])   # Array to store rpms to take average from
        zero = 0                # Set low counters to zero
        prevtime = time.time()  # Determine gap between revolutions

        while True:
            # Get sensor reading from GPIO pin (high or low)
            x = self.get_state()

            if not x:
                # Count readings in low
                zero += 1

            else:
                if zero > lowcount:
                    # Determine how long revolution took
                    revtime = time.time() - prevtime
                    prevtime = time.time()

                    # Check for number of readings to get average
                    if r == thresh:
                        r = 0
                        av = int(np.mean(rpmav))
                        break
                    else:
                        r += 1

                    # Calculate RPM
                    rpm = 60*(1/revtime)
                    rpmav[r] = rpm
                else:
                    pass

                # Reset zero counter
                zero = 0
        
        return av

def cleanAndExit():
    print("Cleaning loadcell...")
    GPIO.cleanup()
    print("DONE")
    sys.exit()

# SETUP
rpm     = RPM(18)
while True:
    try:
        currentrpm = rpm.get_state()

        line = str(currentrpm) + " \n"
        # Save RPMs to file
        with open("rpm.txt", "a") as myfile:
            myfile.write(line)

        # sys.stdout.write('\rRPM = %i         ' % currentrpm)
        # sys.stdout.flush()

    except (KeyboardInterrupt, SystemExit):
        readpersec = rpm.count_rate()
        print("Readings per second = %i" % readpersec)

        cleanAndExit()
        break