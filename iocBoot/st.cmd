#!../bin/linux-x86_64/ioLogik

< ./epicsEnv.cmd

## Register all support components
dbLoadDatabase "$(TOP)/dbd/ioLogik.dbd"
ioLogik_registerRecordDeviceDriver pdbbase

epicsEnvSet("SYSNAME","XF:08BMA-GH")
epicsEnvSet("CTSYS","XF:08BM-CT")

#######################################################################
# set ASYN port name variable ('RIO' + last_byte_of_IP_address)

# ### E1240 (8AI) ###
epicsEnvSet("E1240_ASYN1","E1240_1")

# ### E1241 (4AO) ###
epicsEnvSet("E1241_ASYN1","E1241_1")
epicsEnvSet("E1241_ASYN2","E1241_2")

drvAsynIPPortConfigure("$(E1240_ASYN1)", "xf08bm-io5.nsls2.bnl.local:502", 0, 0, 1)
drvAsynIPPortConfigure("$(E1241_ASYN1)", "xf08bm-io6.nsls2.bnl.local:502", 0, 0, 1)
drvAsynIPPortConfigure("$(E1241_ASYN2)", "xf08bm-io7.nsls2.bnl.local:502", 0, 0, 1)

#######################################################################
# modbusInterposeConfig(const char *portName,
#                      modbusLinkType linkType, .... Modbus link layer type: 0 = TCP/IP , 1 = RTU, 2 = ASCII
#                      int timeoutMsec, 
#                      int writeDelayMsec)
modbusInterposeConfig("$(E1240_ASYN1)", 0, 2000, 0)
modbusInterposeConfig("$(E1241_ASYN1)", 0, 2000, 0)
modbusInterposeConfig("$(E1241_ASYN2)", 0, 2000, 0)

#######################################################################
# modbus port driver is created with the following command:
#drvModbusAsynConfigure(portName, 
#                        tcpPortName,
#                        slaveAddress, 
#                        modbusFunction, 
#                        modbusStartAddress, 
#                        modbusLength,
#                        dataType,
#                        pollMsec, 
#                        plcType);
#######################################################################

##Modbus functions
#Function name                          Function code
#Read Discrete Inputs                    2
#Read Coils                              1
#Write Single Coil                       5
#Write Multiple Coils                   15
#Read Input Registers                    4
#Read Holding Registers                  3
#Write Single Register                   6
#Write Multiple Registers               16
#Read/Write Multiple Registers          23
#Mask Write Register                    22
#Read FIFO Queue                        24
#Read File Record                       20
#Write File Record                      21
#Read Exception Status                   7
#Diagnostic                              8
#Get Com Event Counter                  11
#Get Com Event Log                      12
#Report Slave ID                        17
#Read Device Identification             43
#Encapsulated Interface Transport       43
#
#######################################################################

#######################################################################
#Supported Modbus data types
#modbusDataType value 	drvUser field 	Description
#0 	UINT16 	Unsigned 16-bit binary integers
#1 	INT16SM 	16-bit binary integers, sign and magnitude format. In this format bit 15 is the sign bit, and bits 0-14 are the absolute value of the magnitude of the number. 
#			This is one of the formats used, for example, by Koyo PLCs for numbers such as ADC conversions.
#2 	BCD_UNSIGNED 	Binary coded decimal (BCD), unsigned. This data type is for a 16-bit number consisting of 4 4-bit nibbles, each of which encodes a decimal number from 0-9. 
#			A BCD number can thus store numbers from 0 to 9999. Many PLCs store some numbers in BCD format.
#3 	BCD_SIGNED 	4-digit binary coded decimal (BCD), signed. This data type is for a 16-bit number consisting of 3 4-bit nibbles, and one 3-bit nibble. 
#			Bit 15 is a sign bit. Signed BCD numbers can hold values from -7999 to +7999. This is one of the formats used by Koyo PLCs for numbers such as ADC conversions.
#4 	INT16 		16-bit signed (2's complement) integers. This data type extends the sign bit when converting to epicsInt32.
#5 	INT32_LE 	32-bit integers, little endian (least significant word at Modbus address N, most significant word at Modbus address N+1)
#6 	INT32_BE 	32-bit integers, big endian (most significant word at Modbus address N, least significant word at Modbus address N+1)
#7 	FLOAT32_LE 	32-bit floating point, little endian (least significant word at Modbus address N, most significant word at Modbus address N+1)
#8 	FLOAT32_BE 	32-bit floating point, big endian (most significant word at Modbus address N, least significant word at Modbus address N+1)
#9 	FLOAT64_LE 	64-bit floating point, little endian (least significant word at Modbus address N, most significant word at Modbus address N+3)
#10 	FLOAT64_BE 	64-bit floating point, big endian (most significant word at Modbus address N, least significant word at Modbus address N+3)
#######################################################################


epicsEnvSet("E12xx_ASYNPORT","$(E1240_ASYN1)")
epicsEnvSet("DEV", "{SC:1-MFC:1}IO:1-")
< ioLogik_E1240.cmd
# Load database
dbLoadRecords("$(TOP)/db/ioLogik_E1240_1.db","Sys=$(SYSNAME), Dev=$(DEV), ASYNPORT=$(E12xx_ASYNPORT)")

epicsEnvSet("E12xx_ASYNPORT","$(E1241_ASYN1)")
epicsEnvSet("DEV", "{SC:1-MFC:1}IO:2-")
< ioLogik_E1241.cmd
# Load database
dbLoadRecords("$(TOP)/db/ioLogik_E1241_1.db","Sys=$(SYSNAME), Dev=$(DEV), ASYNPORT=$(E12xx_ASYNPORT)")

epicsEnvSet("E12xx_ASYNPORT","$(E1241_ASYN2)")
epicsEnvSet("DEV", "{SC:1-MFC:1}IO:3-")
< ioLogik_E1241.cmd
# Load database
dbLoadRecords("$(TOP)/db/ioLogik_E1241_1.db","Sys=$(SYSNAME), Dev=$(DEV), ASYNPORT=$(E12xx_ASYNPORT)")
dbLoadRecords("$(TOP)/db/iocAdminSoft.db", "IOC=$(CTSYS){SC:1-MFC:1}")

epicsEnvSet("DEV", "{SC:1-MFC:1}")
dbLoadTemplate("./gasFlowCalc.substitutions", "Sys=$(SYSNAME), Dev=$(DEV)")

# ======== AUTOSAVE ===========
#save_restoreSet_Debug(0)
#save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_requestfile_path("./")
set_requestfile_path("$(TOP)/autosave/req")
set_savefile_path("${TOP}/autosave","/save")

# set_pass0_restoreFile("auto_positions.sav")
set_pass0_restoreFile("auto_settings.sav")
set_pass1_restoreFile("auto_settings.sav")
# ==============================

iocInit

#create_triggered_set("auto_settings.req", "XF:08BMA-GH{SC:1-MFC:1}AO:5-SP", "P=$(SYSNAME)$(DEV)")
create_monitor_set("auto_settings.req", 15, "P=$(SYSNAME)$(DEV)")

dbpf $(SYSNAME)$(DEV)IO:1-AI:1-I.DESC "Input Chan 1"
dbpf $(SYSNAME)$(DEV)IO:1-AI:2-I.DESC "Input Chan 2"
dbpf $(SYSNAME)$(DEV)IO:1-AI:3-I.DESC "Input Chan 3"
dbpf $(SYSNAME)$(DEV)IO:1-AI:4-I.DESC "Input Chan 4"
dbpf $(SYSNAME)$(DEV)IO:1-AI:5-I.DESC "Input Chan 5"
dbpf $(SYSNAME)$(DEV)IO:1-AI:6-I.DESC "Input Chan 6"
dbpf $(SYSNAME)$(DEV)IO:1-AI:7-I.DESC "Input Chan 7"
dbpf $(SYSNAME)$(DEV)IO:1-AI:8-I.DESC "Input Chan 8"

dbpf $(SYSNAME)$(DEV)IO:2-AO:1-SP.DESC "Output Chan 1 (0-10V)"
dbpf $(SYSNAME)$(DEV)IO:2-AO:2-SP.DESC "Output Chan 2 (0-10V)"
dbpf $(SYSNAME)$(DEV)IO:2-AO:3-SP.DESC "Output Chan 3 (0-10V)"
dbpf $(SYSNAME)$(DEV)IO:2-AO:4-SP.DESC "Output Chan 4 (0-10V)"

dbpf $(SYSNAME)$(DEV)IO:3-AO:1-SP.DESC "Output Chan 5 (0-10V)"
dbpf $(SYSNAME)$(DEV)IO:3-AO:2-SP.DESC "Output Chan 6 (0-10V)"
dbpf $(SYSNAME)$(DEV)IO:3-AO:3-SP.DESC "Output Chan 7 (0-10V)"
dbpf $(SYSNAME)$(DEV)IO:3-AO:4-SP.DESC "Output Chan 8 (0-10V)"

dbpf $(SYSNAME)$(DEV)AI:1-I.DESC "He"
dbpf $(SYSNAME)$(DEV)AI:2-I.DESC "CH4"
dbpf $(SYSNAME)$(DEV)AI:3-I.DESC "H2"
dbpf $(SYSNAME)$(DEV)AI:4-I.DESC "NO/NH3"
dbpf $(SYSNAME)$(DEV)AI:5-I.DESC "CO"
dbpf $(SYSNAME)$(DEV)AI:6-I.DESC "CO2"
dbpf $(SYSNAME)$(DEV)AI:7-I.DESC "O2"
dbpf $(SYSNAME)$(DEV)AI:8-I.DESC "-"

