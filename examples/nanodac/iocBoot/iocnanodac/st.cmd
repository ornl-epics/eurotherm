#!../../bin/linux-x86_64/nanodac

## You may have to change nanodac to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/nanodac.dbd"
nanodac_registerRecordDeviceDriver pdbbase

####################################################
# TCP to Eurotherm

drvAsynIPPortConfigure("n1ip","192.168.200.177:502",0,0,1)

####################################################

####################################################################
# Set up modbus TCP support for Eurotherm
        
# modbusInterposeConfig
# arg 1: portName
# arg 2: linkType
# arg 3: timeoutMsec
# arg 4: writeDelayMsec
modbusInterposeConfig("n1ip", 0, 2000, 100)

# drvModbusAsynConfigure
# arg 1: portName
# arg 2: tcpPortName
# arg 3: slaveAddress 
# arg 4: modbusFunction 
# arg 5: modbusStartAddress 
# arg 6: modbusLength
# arg 7: default dataType
# arg 8: pollMsec 
# arg 9: plcType

# Read channels 1-4 and virtual channels 1-6 (PV value, status and alarm).
drvModbusAsynConfigure("n1ch", "n1ip", 1, 4, 256, 16, 4, 100, 0)
drvModbusAsynConfigure("n1vch", "n1ip", 1, 4, 288, 24, 4, 100, 0)

# Read the resolutions values for each channel every 10s
drvModbusAsynConfigure("n1ch1res", "n1ip", 1, 4, 6145, 1, 4, 10000, 0)
drvModbusAsynConfigure("n1ch2res", "n1ip", 1, 4, 6273, 1, 4, 10000, 0)
drvModbusAsynConfigure("n1ch3res", "n1ip", 1, 4, 6401, 1, 4, 10000, 0)
drvModbusAsynConfigure("n1ch4res", "n1ip", 1, 4, 6529, 1, 4, 10000, 0)

drvModbusAsynConfigure("n1vch1res", "n1ip", 1, 4, 7170, 1, 4, 10000, 0)
drvModbusAsynConfigure("n1vch2res", "n1ip", 1, 4, 7298, 1, 4, 10000, 0)
drvModbusAsynConfigure("n1vch3res", "n1ip", 1, 4, 7426, 1, 4, 10000, 0)
drvModbusAsynConfigure("n1vch4res", "n1ip", 1, 4, 7554, 1, 4, 10000, 0)
drvModbusAsynConfigure("n1vch5res", "n1ip", 1, 4, 7682, 1, 4, 10000, 0)
drvModbusAsynConfigure("n1vch6res", "n1ip", 1, 4, 7810, 1, 4, 10000, 0)

# Read the loop 1 params
drvModbusAsynConfigure("n1l1", "n1ip", 1, 4, 512, 6, 4, 1000, 0)
# Read the loop 2 params
drvModbusAsynConfigure("n1l2", "n1ip", 1, 4, 640, 6, 4, 1000, 0)

# Write function for loop 1 setpoint
drvModbusAsynConfigure("n1l1w", "n1ip", 1, 6, 514, 1, 4, 1000, 0)
# Write function for loop 2 setpoint
drvModbusAsynConfigure("n1l2w", "n1ip", 1, 6, 542, 1, 4, 1000, 0)

# Read functions for loop 1 output params (5741 to 5776)
drvModbusAsynConfigure("n1l1o", "n1ip", 1, 4, 5741, 36, 4, 1000, 0)
# Read functions for loop 2 output params (5997 to 6032)
drvModbusAsynConfigure("n1l2o", "n1ip", 1, 4, 5997, 36, 4, 1000, 0)
# Write function for loop 1 output params
drvModbusAsynConfigure("n1l1ow", "n1ip", 1, 6, 5741, 36, 4, 1000, 0)
# Write function for loop 2 output params
drvModbusAsynConfigure("n1l2ow", "n1ip", 1, 6, 5997, 36, 4, 1000, 0)

# Read functions for loop 1 PID params (5685 to )
drvModbusAsynConfigure("n1l1p", "n1ip", 1, 4, 5685, 1, 4, 1000, 0)
# Read functions for loop 2 PID params (5941 to )
drvModbusAsynConfigure("n1l2p", "n1ip", 1, 4, 5941, 1, 4, 1000, 0)
# Write function for loop 1 PID params
drvModbusAsynConfigure("n1l1pw", "n1ip", 1, 6, 5685, 1, 4, 1000, 0)
# Write function for loop 2 PID params
drvModbusAsynConfigure("n1l2pw", "n1ip", 1, 6, 5941, 1, 4, 1000, 0)


####################################################################

## Load record instances
dbLoadRecords "db/nanodac.db"

cd ${TOP}/iocBoot/${IOC}
iocInit

