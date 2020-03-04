# Super Bike Lock - WebApp

## Requirements
- Docker
- docker-compose

Install **Docker**: https://docs.docker.com/install/  
Install **docker-compose**: https://docs.docker.com/compose/install/
 
## Development Setup
1. Create a virtual environment in BikeLock/WebApp
```
cd BikeLock/WebApp
python3 -m venv env
```
2. Activate
```
source env/bin/activate   # do you work inside
```
3. Deploy
```
sudo docker-compose up    # grab Docker images and python packages, if necessary
```
4. Write ~~bugs~~ features
