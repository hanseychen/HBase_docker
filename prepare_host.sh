# Run this Script in the folder contains docker file
# Make sure 

# Allow ports in firewall
# HMaster, hbase.master.port
ufw allow 60000
# HMaster Info Web UI (http), hbase.master.info.port
ufw allow 60010
# Region Server, hbase.regionserver.port
ufw allow 60020
# Region Server Web UI(http), hbase.regionserver.info.port
ufw allow 60030

# Zookeeper
# hbase.zookeeper.peerport
ufw allow 2888
# hbase.zookeeper.leaderport
ufw allow 3888
# hbase.zookeeper.property.clientPort
ufw allow 2181

# ssh
ufw allow 21222

# confirm the permission of folders for ssh
chmod go-w ~/
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
# confirm the ownership of folders for ssh
chown pls331pci ~/
chown pls331pci ~/.ssh


# Copy ssh keys into the context of the build
cp ~/.ssh/id_rsa . && \
  cp ~/.ssh/id_rsa.pub . && \
  cp ~/.ssh/authorized_keys . && \
  cp ~/.ssh/known_hosts . && \
  echo ">>> ssh keys copied to the building context"

# change hbase.rootdir for each machine (hbase-site.xml) 
if [ "$HOST" = "CSE-Hcse101389D" ]; then
  sed -i 's/<value>hdfs:\/\/machine01:8020\/hbase<\/value>/<value>hdfs:\/\/machine01:8020\/hbase_machine01<\/value>/' ./hbase-site.xml
else
  if [ "$HOST" = "CSE-Hcse101384D" ]; then
    sed -i 's/<value>hdfs:\/\/machine01:8020\/hbase<\/value>/<value>hdfs:\/\/machine01:8020\/hbase_machine02<\/value>/' ./hbase-site.xml
  else
    if [ "$HOST" = "CSE-Hcse101423D" ]; then
      sed -i 's/<value>hdfs:\/\/machine01:8020\/hbase<\/value>/<value>hdfs:\/\/machine01:8020\/hbase_machine03<\/value>/' ./hbase-site.xml
    else
      echo "Machine Not Identified. Change the hbase folder manually."
    fi
  fi
fi

# Build Docker Image
docker build -t="pls331/centos:hbase-1.2.6-standalone_hdfs" .
