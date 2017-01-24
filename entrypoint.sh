#!/bin/bash

export LIBPROCESS_IP=0.0.0.0
export LIBPROCESS_PORT=7228
export SPARK_MESOS_DISPATCHER_HOST=0.0.0.0
$SPARK_HOME/sbin/start-mesos-dispatcher.sh --master mesos://leader.mesos:5050 &
$LIVY_APP_PATH/bin/livy-server $@
