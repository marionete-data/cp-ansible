#!/bin/bash

BOOTSTRAP_SERVER=broker-1:9092,broker-2:9092,broker-3:9092,broker-4:9092
CONFIG_FILE=/scripts/config/admin.config

if [ $# -ne 1 ]; then
  echo ""
  echo "usage: $0 username"
  echo ""
  exit
fi


USERNAME=$1
shift

COMMAND="--add"

echo ""
echo "providing full cluster access to ${USERNAME}"
echo ""

kafka-acls \
	--bootstrap-server ${BOOTSTRAP_SERVER} \
	--command-config ${CONFIG_FILE} \
	${COMMAND} \
	--force \
	--allow-principal User:${USERNAME} \
	--operation All \
	--topic '*' \
	--group '*' \
	--cluster

# to delete acl replace `--add` with `--remove`
