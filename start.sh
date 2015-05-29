#!/bin/bash


# start crashplan
/opt/crashplan/bin/CrashPlanDesktop

# redirect logs
tail -f /opt/crashplan/log/ui_error.log /opt/crashplan/log/ui_output.log &

# busy wait until we can shut down
while pgrep java > /dev/null;
do
    sleep 5;
done
