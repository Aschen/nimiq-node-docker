#!/bin/bash

CONSENSUS_PATH=/nimiq-consensus
CURRENT_CONSENSUS_PATH="$CONSENSUS_PATH/$NETWORK-full-consensus"


if [ ! -f "$CURRENT_CONSENSUS_PATH/data.mdb" ]; then
  wget https://aschen.ovh/nimiq/$NETWORK/$NETWORK-full-consensus.tar -O $NETWORK-full-consensus.tar
  tar xf $NETWORK-full-consensus.tar -C $CONSENSUS_PATH/
fi

if [ ! -f /core-master/$NETWORK-full-consensus ]; then
  ln -s $CURRENT_CONSENSUS_PATH /core-master/.
fi

NIMIQ_COMMAND_LINE="--statistics $STATS --network $NETWORK "

if [ ! -z "$WALLET" ]; then
  NIMIQ_COMMAND_LINE="$NIMIQ_COMMAND_LINE --wallet-address=$WALLET "
fi

if [ ! -z "$POOL" ]; then
  NIMIQ_COMMAND_LINE="$NIMIQ_COMMAND_LINE --pool $POOL "
fi

if [ ! -z "$HOSTNAME" ]; then
  NIMIQ_COMMAND_LINE="$NIMIQ_COMMAND_LINE --host $HOSTNAME --cert cert.pem --key key.pem"
else
  NIMIQ_COMMAND_LINE="$NIMIQ_COMMAND_LINE --dumb "
fi

if [ ! $MINER_THREADS -eq 0 ]; then
  NIMIQ_COMMAND_LINE="$NIMIQ_COMMAND_LINE --miner $MINER_THREADS "
fi

if [ -z "$CONFIG_FILE" ]; then
  echo "Run Nimiq with this command line"
  echo "node clients/nodejs/index.js $NIMIQ_COMMAND_LINE"

  node clients/nodejs/index.js $NIMIQ_COMMAND_LINE
else
  echo "Run nimiq with this configuration file"
  cat $CONFIG_FILE

  node clients/nodejs/index.js --config $CONFIG_FILE
fi
