#!/usr/bin/env bash

DRILL_HOME="/opt/drill"

${DRILL_HOME}/bin/drillbit.sh status
exit $?