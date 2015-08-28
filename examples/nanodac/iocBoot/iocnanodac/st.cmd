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
modbusInterposeConfig("n1ip", 0, 2000, 0)

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
#drvModbusAsynConfigure("n1", "n1ip", 1, 4, 288, 2, 4, 1000, 0)
drvModbusAsynConfigure("n1", "n1ip", 1, 4, 264, 2, 4, 100, 0)
drvModbusAsynConfigure("n1R", "n1ip", 1, 4, 6401, 1, 4, 10000, 0)

####################################################################

## Load record instances
dbLoadRecords "db/nanodac.db"

cd ${TOP}/iocBoot/${IOC}
iocInit

