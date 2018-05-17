# Nimiq Node in Docker

This is a autonomous container to run Nimiq core client.  

The container will download a snapshot of the blockchain at startup. (See [here](https://aschen.ovh/nimiq))

## Get started

Install Docker : https://docs.docker.com/install/  
Install Docker-Compose : https://docs.docker.com/compose/install/  

Clone this repository : `git clone https://github.com/aschen/nimiq-node-docker`  
Run your Nimiq container : `docker-compose up` (this will run a dumb full node on test network)


## Configuration

You can either configure your Nimiq client with environment variables before the `docker-compose` command or by using a configuration file in the directory `configs/`.  

### Environment variables

You can custom configuration by environment variables :

 - `POOL` : Connect to the specified pool (eg: `POOL=pool.nimiq.com:8444`)
 - `STATS` : Statistics display interval in seconds (eg: `STATS=1`)
 - `MINER_THREADS` : Threads to mine with. Miner disabled if set to 0. (eg: `MINER_THREADS=42`)
 - `HOSTNAME` : Hostname of your full node. You must also provide valid certificates for your domain. Switch to dumb mode if blank. (eg: `HOSTNAME=nimiq.aschen.ovh`)
 - `WALLET` : Wallet address to mine. Will generate a new one if blank. (eg: `WALLET=NQ488CKHBA242VR3N249N8MNJ5XX74DB5XJ8`)
 - `NETWORK` : Network to run the node on. Can be `test`, `dev`, `main` or `bounty`
 - `RECOMPILE` : Recompile the binaries to better mining performance. (eg: `RECOMPILE=yes`)

### Configuration files

There is some configuration file examples in the `configs/` directory.  
You still have to specify the network with environment variable even if it's specified in the configuration file : 
  - `NETWORK=main CONFIG_FILE=configs/smart-pool-miner.conf docker-compose up -d`

## Recipes

### Run a miner

Use the environment variable `RECOMPILE=yes` to enable better mining performance.  

Run a solo miner on main network : 
 - `NETWORK=main MINER_THREADS=12 docker-compose up -d

Run a pool miner on main network : 
 - `NETWORK=main MINER_THREADS=12 POOL=pool.nimiq.com:8444 docker-compose up -d`

Run a pool miner with predefined wallet : 
 - `NETWORK=main MINER_THREADS=12 POOL=pool.nimiq.com:8444 WALLET=NQ488CKHBA242VR3N249N8MNJ5XX74DB5XJ8 docker-compose up -d`

Run a solo miner on test network : 
 - `NETWORK=test MINER_THREADS=1 docker-compose up -d`

### Run a full node

If you are running a full node, you have to provide valid certificates for your domain name.  

You can get free SSL certificate with Let's Encrypt : https://www.digitalocean.com/community/tutorials/how-to-use-certbot-standalone-mode-to-retrieve-let-s-encrypt-ssl-certificates

After getting your certificate, create two symbolic links (for the certificate and the private key) from the letsencrypt folfder to this folder : 
 - `ln -s /etc/letsencrypt/live/your.domain.com/fullchain.pem cert.pem`
 - `ln -s /etc/letsencrypt/live/your.domain.com/privkey.pem key.pem`

Then you can run your full node on the main using this command line :
 - `NETWORK=main HOSTNAME=your.domain.com docker-compose up -d`
