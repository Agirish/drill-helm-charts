#!/usr/bin/env bash

DRILL_HOME="/opt/drill"

DRILLBIT_PID=`cat ${DRILL_HOME}/drillbit.pid`

if [[ -z DRILLBIT_PID ]]
then
  echo "Drill-bit PID does not exist. Assuming that the drill-bit process isn't running."
  exit 0
else
  echo "Gracefully shutting down the drill-bit."
  ${DRILL_HOME}/bin/drillbit.sh graceful_stop
fi