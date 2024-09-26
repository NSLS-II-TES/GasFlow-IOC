TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = ioLogik
# ioLogik.dbd will be created and installed
DBD += ioLogik.dbd

# ioLogik.dbd will be made up from these files:
ioLogik_DBD += base.dbd

# Include dbd files from all support applications:
ioLogik_DBD += asyn.dbd
ioLogik_DBD += drvAsynIPPort.dbd
ioLogik_DBD += modbusSupport.dbd
ioLogik_DBD += devIocStats.dbd
ioLogik_DBD += asSupport.dbd

# Add all the support libraries needed by this IOC
ioLogik_LIBS += asyn modbus devIocStats
ioLogik_LIBS += autosave

# ioLogik_registerRecordDeviceDriver.cpp derives from ioLogik.dbd
ioLogik_SRCS += ioLogik_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
ioLogik_SRCS_DEFAULT += ioLogikMain.cpp
ioLogik_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#ioLogik_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
ioLogik_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

