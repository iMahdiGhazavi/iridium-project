echo ----------------------------------------------------------
echo "Removing the containers..."
echo ----------------------------------------------------------
docker stop server1 server2 server3 attacker web_server

echo ----------------------------------------------------------
echo "Removing the whole docker network"
echo ----------------------------------------------------------
docker network rm simnet
