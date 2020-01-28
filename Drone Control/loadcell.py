import time
import sys

EMULATE_HX711=False

referenceUnit = 1

if not EMULATE_HX711:
    import RPi.GPIO as GPIO
    from hx711 import HX711
else:
    from emulated_hx711 import HX711

def cleanAndExit():
    print("Cleaning...")

    if not EMULATE_HX711:
        GPIO.cleanup()
        
    print("Bye!")
    sys.exit()

hx = HX711(24, 23)
hx.set_reading_format("MSB", "MSB")

print("Set Zero Weight")

hx.reset()
hx.tare()

print("Tare done. Add weight now...")

try:
    calin = input("Weight added (grams/ [ ENTER for default ] ): ")
    gravity = 9.81

    print "____"
    print "Input Weight = %f grams" % calin
    # to use both channels, you'll need to tare them both
    #hx.tare_A()
    #hx.tare_B()

    calout = hx.get_weight(5)
    print "Raw Value = %f" % calout
    # y = Ax + B - Assume B set by tare. Therefore A...

    Ax = calin*gravity/calout

except SyntaxError:
    calin = 309.5
    print("Calibration weight set to default (309.5g)")
    Ax = -0.00390069915156

print "Calibration factor = %s " % Ax
while True:
    try:
        val = hx.get_weight(20)
        force = val*Ax

        sys.stdout.write('\rForce = %.3f mN' % force)
        sys.stdout.flush()

        # To get weight from both channels (if you have load cells hooked up 
        # to both channel A and B), do something like this
        #val_A = hx.get_weight_A(5)
        #val_B = hx.get_weight_B(5)
        #print "A: %s  B: %s" % ( val_A, val_B )

        hx.power_down()
        hx.power_up()

    except (KeyboardInterrupt, SystemExit):
        cleanAndExit()

