# MOXA E12xx AIs : function 4 (Read Input Registers), address 0, length 8, data_type = UINT16 = 0,
# pollMsec = for read func, waits XXX msecs
drvModbusAsynConfigure("$(E12xx_ASYNPORT)_AI", "$(E12xx_ASYNPORT)", 0, 4, 0, 8, 0, 100, "ioLogik")

# MOXA E12xx Current mode status: function 4, address 60, 8 words , data_type = UINT16 = 0, 
# pollMsec = for read func, waits XXX msecs
drvModbusAsynConfigure("$(E12xx_ASYNPORT)_AI_St", "$(E12xx_ASYNPORT)", 0, 4, 60, 8, 0, 500, "ioLogik")

# MOXA E12xx Current mode settings read: function 3, address 24, 8 words , data_type = UINT16 = 0, 
# pollMsec = for read func, waits XXX msecs
drvModbusAsynConfigure("$(E12xx_ASYNPORT)_AIMR", "$(E12xx_ASYNPORT)", 0, 3, 24, 4, 0, 500, "ioLogik")

# MOXA E12xx Current mode settings write: function 6, address 24, 8 double words, data_type = UINT16 = 0, 
# pollMsec = for read func, waits XXX msecs
drvModbusAsynConfigure("$(E12xx_ASYNPORT)_AIMW", "$(E12xx_ASYNPORT)", 0, 6, 24, 4, 0, 1, "ioLogik")

## Load record instances
#dbLoadRecords("db/ioLogik_E1240.db","Sys=$(SYSNAME), Dev=$(DEV), ASYNPORT=$(E12xx_ASYNPORT)")

