#!/bin/bash


# start crashplan
/opt/crashplan/bin/CrashPlanDesktop

# attach to logs
tail -f /opt/crashplan/log/ui_error.log /opt/crashplan/log/ui_output.log
