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

    def get_state(self):
        return GPIO.input(self.outpin)

    def get_rpm(self, readings=10, lowcount=30)
        thresh = readings-1     # Number of readings to average
        n = 0                   # Count number of readings taken
        r = 0                   # Count number of revolutions
        av = 0                  # Average number of revs (in 10)
        rpmav = np.array([0])   # Array to store rpms to take average from
        zero = 0                # Set low counters to zero
        start = time.time()     # Use to determine number of readings per second
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
                        r1 += 1

                    # Calculate RPM
                    rpm = 60*(1/revtime)
                    rpmav[r] = rpm
                else:
                    pass

                # Reset zero counter
                zero = 0

            # Count readings
            n += 1
        
        return av

    def cleanAndExit():
        print("Cleaning RPM...")
        GPIO.cleanup()
        print("DONE")
        sys.exit()

class loadcell:
    def __init__(self, pins=[24,23], units='mN',calweight=309.5, calfactor=-0.00390069915156)
        self.pins = pins
        self.units = units
        self.calweight = calweight
        self.calfactor = calfactor

        self.lc = HX711(self.pins[0], self.pins[1])

        self.lc.set_reading_format("MSB", "MSB")

        print("Set Zero Weight")
        self.lc.reset()
        self.lc.tare()
        print("Tare done. Add weight now...")

        try:
            calin = input("Weight added (grams/ [ ENTER for default ] ): ")
            gravity = 9.81

            print "____"
            print "Input Weight = %f grams" % calin
            # to use both channels, you'll need to tare them both
            #hx.tare_A()
            #hx.tare_B()

            calout = self.lc.get_weight(5)
            print "Raw Value = %f" % calout
            # y = Ax + B - Assume B set by tare. Therefore A...

            Ax = calin*gravity/calout

        except SyntaxError: # User hits ENTER, enabling use of previous calibration values
            calin = self.calweight
            print("Calibration weight set to default (309.5g)")
            Ax = self.calfactor

        print "Calibration factor = %s " % Ax

    def thrust(times=10):
        val = self.lc.get_weight(times)
        force = val*Ax

        self.lc.power_down()
        self.lc.power_up()

        return force

    def cleanAndExit():
        print("Cleaning loadcell...")
        GPIO.cleanup()
        print("DONE")
        sys.exit()

# SETUP
rpm     = RPM(5)
thr     = loadcell()

while True:
    try:
        currentrpm = rpm.get_rpm()
        currentthr = thr.thrust()

        sys.stdout.write('\rForce = %.4e %s    RPM = %i         ' % (currentthr, force.units, currentrpm))
        sys.stdout.flush()

    except (KeyboardInterrupt, SystemExit):
        rpm.cleanAndExit()
        thr.cleanAndExit()
        break