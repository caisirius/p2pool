#!/bin/bash

# !! before running this script, build image first: docker build -t freecash/p2pool:0.1.snapshot .

if [ "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" != "$(pwd)" ]; then
    echo "please run in the path where the script is located!"
    exit 1
fi

# please modify params below:
payout_address=mhf3NbUU8zFTCBg14D9tifsyiyyPrVYoDK
fc_node_ip=172.234.95.77

if [ $# -lt 1 ]; then
    echo '
Usage:  ./run_docker.sh NETTYPE

NETTYPE should in "mainnet" or "testnet"'
    exit 1
fi

if [ "$1" = "mainnet" ]; then
    echo "start freecash_p2pool in mainnet"
    docker run -itd --name freecash_p2pool -v $PWD:/opt/p2pool \
-p 19666:19666 -p 19667:19667 -p 9666:9666 -p 9667:9667 \
freecash/p2pool:0.1.snapshot \
python /opt/p2pool/run_p2pool.py --net freecash -a $payout_address --bitcoind-address $fc_node_ip --bitcoind-config-path /opt/p2pool/fc.conf
elif [ "$1" = "testnet" ]; then
    echo "start freecash_p2pool in testnet"
    docker run -itd --name freecash_p2pool -v $PWD:/opt/p2pool \
-p 19666:19666 -p 19667:19667 -p 9666:9666 -p 9667:9667 \
freecash/p2pool:0.1.snapshot \
python /opt/p2pool/run_p2pool.py --net freecash --testnet -a $payout_address --bitcoind-address $fc_node_ip --bitcoind-config-path /opt/p2pool/fc.conf
else
    echo "param unsupported: $1"
    exit -1
fi
echo "   freecash_p2pool started. please check the docker status using 'docker ps'"
echo "   check logs using 'docker logs -n 50 -f freecash_p2pool'"