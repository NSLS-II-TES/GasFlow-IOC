TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install) into <top>/db
# databases, templates, substitutions like this

DB += ioLogik_E1241_1.db
DB += ioLogik_E1241_2.db
DB += ioLogik_E1242_1.db
DB += ioLogik_E1240_1.db
DB += ioLogik_E1214_1.db
DB += ioLogik_E1260_1.db
DB += ioLogik_E1262_1.db

DB_INSTALLS += $(EPICS_BASE)/db/iocAdminSoft.db

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_template = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

