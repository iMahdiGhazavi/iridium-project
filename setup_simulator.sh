echo ----------------------------------------------------------
echo "Creating the docker network..."
echo ----------------------------------------------------------
docker network create simnet

echo ----------------------------------------------------------
echo "Creating the target servers..."
echo ----------------------------------------------------------
docker run -dit --rm --name server1 --network simnet --user root target-server:1.0.0
docker run -dit --rm --name server2 --network simnet --user root target-server:1.0.0
docker run -dit --rm --name server3 --network simnet --user root target-server:1.0.0

echo ----------------------------------------------------------
echo "Starting ssh and ftp services on the target servers..."
echo ----------------------------------------------------------
temp=$(docker exec -it server1 rc-service sshd start)
temp=$(docker exec -it server1 rc-service vsftpd start)
temp=$(docker exec -it server2 rc-service sshd start)
temp=$(docker exec -it server3 rc-service vsftpd start)
temp=$(docker exec -it server1 rc-service crond start)
temp=$(docker exec -it server2 rc-service crond start)
temp=$(docker exec -it server3 rc-service crond start)

echo ----------------------------------------------------------
echo "Creating the web server..."
echo ----------------------------------------------------------
docker run -dit --rm --name web_server --network simnet --user root -p 8000:8000 web-server:1.0.0

echo ----------------------------------------------------------
echo "Creating the attacker machine..."
echo ----------------------------------------------------------
docker run -it --rm --name attacker --network simnet --user root attacker-machine:1.0.0
