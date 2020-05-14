TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install)
# databases, templates, substitutions like this
DB += nanodac.db
DB += nanodac_pv.db
DB += nanodac_loop_main.db
DB += nanodac_loop_output.db
DB += nanodac_loop_pid.db
DB += nanodac_loop_setpoint.db
DB += pid_set_window.db
DB += nanodac_loop_adv.db

# New absolute addressing version
DB += nd.db
DB += nd_pv.db

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_TEMPLATE = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

