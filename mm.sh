docker build -t nod .
cd Routes
docker build -t mysq .
docker stop no
docker stop my
docker rm no
docker rm my
# docker run --name my -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -d mysq
# docker run --name no -p 4000:4000 -d --link my nod