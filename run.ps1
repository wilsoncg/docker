multipass mount . ubuntu-mpass1
multipass mount . ubuntu-mpass2
multipass mount . ubuntu-mpass3

multipass exec ubuntu-mpass1 -- sudo docker swarm init
multipass exec ubuntu-mpass2 -- sudo docker swarm join --token SWMTKN-1-0lt4v1zc7kqzd2lmrrf2uyh6z6oi5tdk4f6e4s6bvxb3jxccyx-dkuviszyruglf4cgfm8093x3p ubuntu-mpass1:2377
multipass exec ubuntu-mpass3 -- sudo docker swarm join --token SWMTKN-1-0lt4v1zc7kqzd2lmrrf2uyh6z6oi5tdk4f6e4s6bvxb3jxccyx-dkuviszyruglf4cgfm8093x3p ubuntu-mpass1:2377

# follow swarm stack deploy guide
# https://docs.docker.com/engine/swarm/stack-deploy/

multipass exec ubuntu-mpass1 -- sudo docker stack deploy --compose-file /home/ubuntu/D:/Projects/docker/myfiles/swarm/docker-compose.yml voteapp

# /var/snap/docker/current/config/daemon.json
# sudo snap restart docker
