echo ----------------------------------------------------------
echo Building the attacker image
echo ----------------------------------------------------------
cd attacker-image
docker build . -t attacker-machine:1.0.0
cd ..

echo ----------------------------------------------------------
echo Building the target image
echo ----------------------------------------------------------
cd target-server-image
docker build . -t target-server:1.0.0
cd ..

echo ----------------------------------------------------------
echo Building the web image
echo ----------------------------------------------------------
cd web-server-image/backend
docker build . -t web-server:1.0.0
cd ../..
