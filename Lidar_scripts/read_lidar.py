import smbus
import time
import serial


bus = smbus.SMBus(1)
address = 0x62

ser = serial.Serial(
        port='/dev/ttyAMA0',
        baudrate = 9600,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        bytesize=serial.EIGHTBITS,
        timeout=1
)

timeout = 0.1
delay = 0.55

try:
	while True:
		try:
			bus.write_byte_data(address, 0x00, 0x04)
			time.sleep(0.02)
			data_lsb = bus.read_byte_data(address, 0x10)
			data_msb = bus.read_byte_data(address, 0x0f)
			data = (data_msb << 8) + data_lsb
			if(data_msb > 127):
        			ser.write('Error')
			else:
				ser.write('ba')
				#ser.write('%x'%(data))
				if(data_msb > 9):
					ser.write('%d'%(data_msb))
				else:
					ser.write('%d'%(0))
					ser.write('%d'%(data_msb))
				if(data_lsb > 9):
					ser.write('%d'%(data_lsb))
				else:
					ser.write('%d'%(0))
					ser.write('%d'%(data_lsb))
				ser.write('x\n')

		except IOError:
			time.sleep(0.1)
except KeyboardInterrupt:
	print "\nInterrupt received to stop sampling"
