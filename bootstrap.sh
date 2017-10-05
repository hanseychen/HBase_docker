#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}

# Add IP-Host mapping into /etc/Hosts
echo "164.107.119.20      machine01" >> /etc/hosts
echo "164.107.119.21      machine02" >> /etc/hosts
echo "164.107.119.22      machine03" >> /etc/hosts

# TODO 
$HBASE_PREFIX/conf/hbase-env.sh

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
# cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# TODO format namenode during run time
# $HADOOP_PREFIX/bin/hdfs namenode -format

service sshd start

# Better to start HDFS manually, since it's not on the same machine any more.
# use my-start-cluster-from-master.sh on master
# $HADOOP_PREFIX/sbin/start-dfs.sh
# $HADOOP_PREFIX/sbin/start-yarn.sh
# $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver

# Keep container Running while run in background
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
