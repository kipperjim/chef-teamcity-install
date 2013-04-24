#! /bin/sh
# /etc/init.d/teamcity
#

# Set path to data
export TEAMCITY_DATA_PATH="<%= @teamcity_data_path %>"

# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo "Starting script teamcity "
    <%= @teamcity_path %>/bin/runAll.sh start
    ;;
  stop)
    echo "Stopping script teamcity"
    <%= @teamcity_path %>/bin/runAll.sh stop
    ;;
  *)
    echo "Usage: /etc/init.d/teamcity {start|stop}"
    exit 1
    ;;
esac

exit 0