docker build -t nod .
cd Routes
docker build -t mysq .
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
# docker run --name my -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -d mysq
# docker run --name no -p 4000:4000 -d --link my nod