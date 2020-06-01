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

epicsEnvSet("IP_ADDR","10.112.133.160:502")

####################################################

####################################################################
# Set up modbus TCP support for Eurotherm

epicsEnvSet("NI","1")

< $(EUROTHERM)/nd.st.cmd.main

asynSetTraceMask(n11w4,0,0xFF)
asynSetTraceMask(n12w4,0,0xFF)
asynSetTraceMask(n13w4,0,0xFF)

####################################################################

## Load record instances
dbLoadRecords "db/nanodac.db"

#################################################
# autosave

epicsEnvSet IOCNAME eurotherm_absolute
epicsEnvSet SAVE_DIR /home/controls/var/$(IOCNAME)

save_restoreSet_Debug(0)

### status-PV prefix, so save_restore can find its status PV's.
save_restoreSet_status_prefix("SECAGE:CS:ND7B:")

set_requestfile_path("$(SAVE_DIR)")
set_savefile_path("$(SAVE_DIR)")

save_restoreSet_NumSeqFiles(3)
save_restoreSet_SeqPeriodInSeconds(600)
set_pass0_restoreFile("$(IOCNAME).sav")
set_pass0_restoreFile("$(IOCNAME)_pass0.sav")
set_pass1_restoreFile("$(IOCNAME).sav")

#################################################

cd ${TOP}/iocBoot/${IOC}
iocInit


# Create request file and start periodic 'save'
epicsThreadSleep(5)
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME).req", "autosaveFields")
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME)_pass0.req", "autosaveFields_pass0")
create_monitor_set("$(IOCNAME).req", 5)
create_monitor_set("$(IOCNAME)_pass0.req", 30)



