#!/usr/bin/env bash

DRILL_HOME="/opt/drill"
DRILL_ENV_FILE="${DRILL_HOME}/conf/distrib-env.sh"
DRILL_CONF_FILE="${DRILL_HOME}/conf/drill-distrib.conf"
DRILL_CONF_OVERRIDE_FILE="${DRILL_HOME}/conf/drill-override.conf"

# Configuring Drill memory
DRILL_MAX_MEMORY_VALUE=`echo ${DRILL_MAX_MEMORY} | tr -dc '0-9'`
sed -i "s/__DRILL_MAX_MEMORY_VALUE__/${DRILL_MAX_MEMORY_VALUE}/g" ${DRILL_ENV_FILE}

# Configuring ZK connection
ZK_HOST="zk-service"
ZK_PORT=2181
sed -i '/cluster-id/d' ${DRILL_CONF_OVERRIDE_FILE}
sed -i '/zk\.connect/d' ${DRILL_CONF_OVERRIDE_FILE}
sed -i "s/__ZK_HOST__/${ZK_HOST}/g" ${DRILL_CONF_FILE}
sed -i "s/__ZK_PORT__/${ZK_PORT}/g" ${DRILL_CONF_FILE}

# Configuring ZK node entry
DRILL_CLUSTER_ID="cluster1"
sed -i "s/__DRILL_ZK_ROOT__/${DRILL_ZK_ROOT}/g" ${DRILL_CONF_FILE}
sed -i "s/__DRILL_CLUSTER_ID__/${DRILL_CLUSTER_ID}/g" ${DRILL_CONF_FILE}

# Configuring ports
DRILL_BIT_SERVER_PORT=$((${DRILL_USER_SERVER_PORT}+1))
sed -i "s/__DRILL_USER_SERVER_PORT__/${DRILL_USER_SERVER_PORT}/g" ${DRILL_CONF_FILE}
sed -i "s/__DRILL_BIT_SERVER_PORT__/${DRILL_BIT_SERVER_PORT}/g" ${DRILL_CONF_FILE}
sed -i "s/__DRILL_HTTP_PORT__/${DRILL_HTTP_PORT}/g" ${DRILL_CONF_FILE}

# Starting Drillbits
${DRILL_HOME}/bin/drillbit.sh status 2>&1 | grep -i "drillbit is running." > /dev/null
if [[ $? -ne 0 ]]
then
  ${DRILL_HOME}/bin/drillbit.sh start
else
  ${DRILL_HOME}/bin/drillbit.sh restart
fi

# Drillbit status
${DRILL_HOME}/bin/drillbit.sh status

# Keep container alive
while true; do sleep 5; done
