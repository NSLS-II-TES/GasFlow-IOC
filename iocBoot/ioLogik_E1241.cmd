# MOXA E12xx AOs: function 6 (Write Single Register), address 1024, 4 words , data_type = UINT16 = 0, 
drvModbusAsynConfigure("$(E12xx_ASYNPORT)_AO", "$(E12xx_ASYNPORT)", 0, 6, 1024, 4, 0, 1, "ioLogik")

# MOXA E12xx AOs: function 3 (Read Holding Registers), address 1024, 4 words , data_type = UINT16 = 0, 
drvModbusAsynConfigure("$(E12xx_ASYNPORT)_AO_RBV", "$(E12xx_ASYNPORT)", 0, 3, 1024, 4, 0, 100, "ioLogik")

## Load record instances
#dbLoadRecords("db/ioLogik_E1241.db","Sys=$(SYSNAME), Dev=$(DEV), ASYNPORT=$(E12xx_ASYNPORT)")

