#!/bin/bash

# tunnel to service
[ -z $SERVICE_ADDR ] && SERVICE_ADDR=service;
socat TCP4-LISTEN:4243 TCP4:$SERVICE_ADDR:4243 &

# start crashplan
/opt/crashplan/bin/CrashPlanDesktop

# redirect logs
tail -f /opt/crashplan/log/ui_error.log /opt/crashplan/log/ui_output.log &

# busy wait until we can shut down
while pgrep java > /dev/null;
do
    sleep 5;
done
