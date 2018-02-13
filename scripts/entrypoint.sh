#!/bin/bash
AGENT_STARTED="false"

while [ ${AGENT_STARTED} != "true" ]; do
  pgrep -x "java" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Jenkins Agent has started"
    AGENT_STARTED="true"
  else
    echo "Waiting for Jenkins Agent to start"
  fi
done

echo "Entering infinite loop"
FOREVER="false"
while [ ${FOREVER} != "true" ]; do
  sleep 10
done
