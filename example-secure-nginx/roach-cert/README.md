docker build --no-cache -t roach-cert .

docker run -it roach-cert

docker exec -it roach-cert /bin/bash