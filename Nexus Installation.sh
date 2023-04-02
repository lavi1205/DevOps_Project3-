hostnamectl set-hostname Nexus
apt-get update
apt-get install docker.io
apt-get install docker-compose -y
usermod -aG docker $USER

echo '

version: "3"
services:
  nexus:
    image: sonatype/nexus3
    restart: always
    volumes:
      - "nexus-data:/sonatype-work"
    ports:
      - "8081:8081"
      - "8085:8085"

volumes:
  nexus-data: {} > docker-composenexus.yml
docker-compose up -d
docker exec -it ubuntu_nexus_1 cat /nexus-data/admin.password
