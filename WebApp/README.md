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
source env/bin/activate    # do you work inside
```
3. Build
```
sudo docker-compose build  # grab Docker images and Python packages
```
4. Database Setup
```
python3 manage.py migrate
```
5. Write ~~bugs~~ features

## Deploy
Start development server at http://0.0.0.0:8000
```
sudo docker-compose up
```

# API

## \<domain\>/api/station/
**GET**    Get all station UUIDs and IP addresses.

---
## \<domain\>/api/lock/

**POST**    Request a lock.

Payload (JSON):
```
{
    "uuid": <station UUID>,
    "lock_id": <lock ID (string "0" or "1")>,
    "state": <off or on (string "0" or "1")>
}
```
---
