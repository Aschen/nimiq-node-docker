# Nimiq Node in Docker

This is a autonomous container to run Nimiq core client.  

The container will download a snapshot of the blockchain at startup. (See [here](https://aschen.ovh/nimiq))

## Get started

Install Docker : https://docs.docker.com/install/  
Install Docker-Compose : https://docs.docker.com/compose/install/  

Clone this repository : `git clone https://github.com/aschen/nimiq-node-docker`  
Run your Nimiq container : `docker-compose up` (this will run a dumb full node on test network)


## Configuration

You can custom configuration by environment variables :

 - `POOL` : Connect to the specified pool (eg: `POOL=pool.nimiq.com:8444`)
 - `STATS` : Statistics display interval in seconds (eg: `STATS=1`)
 - `MINER_THREADS` : Threads to mine with. Miner disabled if set to 0. (eg: `MINER_THREADS=42`)
 - `HOSTNAME` : Hostname of your full node. You must also provide valid certificates for your domain. Switch to dumb mode if blank. (eg: `HOSTNAME=nimiq.aschen.ovh`)
 - `WALLET` : Wallet address to mine. Will generate a new one if blank. (eg: `WALLET=NQ488CKHBA242VR3N249N8MNJ5XX74DB5XJ8`)
 - `NETWORK` : Network to run the node on. Can be `test`, `dev`, `main` or `bounty`

Or you can edit the configuration file `node.conf` and then specify the client to use it.  
You still have to specify the network with environment variable even if it's specified in the configuration file : `NETWORK=main CONFIG_FILE=configs/smart-pool-miner.conf docker-compose up -d`

#### /!\ Running a full node

If you are running a full node, you have to provide valid certificates for your domain name.  
Put the certificate in `cert.pem` and the private key in `key.pem`.  
You can get free SSL certificate with Let's Encrypt : https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-16-04

## Recipes

Run a solo miner on main network : `NETWORK=main MINER_THREADS=12 docker-compose up -d`

Run a pool miner on main network : `NETWORK=main MINER_THREADS=12 POOL=pool.nimiq.com:8444 docker-compose up -d`

Run a pool miner with predefined wallet : `NETWORK=main MINER_THREADS=12 POOL=pool.nimiq.com:8444 WALLET=NQ488CKHBA242VR3N249N8MNJ5XX74DB5XJ8 docker-compose up -d`

Run a full node without miner on main network : `NETWORK=main HOSTNAME=nimiq.aschen.ovh docker-compose up -d`

Run a solo miner on test network : `NETWORK=test MINER_THREADS=1 docker-compose up -d`
