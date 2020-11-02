echo "Entered number of server's is $1, Bitnami pasword is $2"
printf "version: '2'\nservices:" > docker.test
i=0
nodes=''
while [ $i -lt $1 ]
do 
    printf "\n  redis-node-$i:\n    image: docker.io/bitnami/redis-cluster:6.0-debian-10\n    volumes:\n     - redis-cluster_data-$i:/bitnami/redis/data\n    env_file:\n     - ./redis.env\n" >> docker.test
    nodes+=$(echo "redis-node-$i ")
    i=$(($i+1))
done

j=0
printf "  redis-cluster-init:\n    image: docker.io/bitnami/redis-cluster:6.0-debian-10\n    depends_on:\n      -" >> docker.test
while [ $j -lt $1 ]
do 
    printf "\n      - redis-node-$j" >> docker.test
    j=$(($j+1))
done
printf "\n    env_file:\n     - ./redis-init.env\n"

k=0
printf "volumes: ">> docker.test
while [ $k -lt $1 ]
do 
    printf "\n  redis-cluster_data-$k:\n    driver: local" >> docker.test
    k=$(($k+1))
done
echo $nodes
printf "REDIS_PASSWORD=$2\nREDIS_CLUSTER_REPLICAS=$3\nREDIS_NODES=$nodes\nREDIS_CLUSTER_CREATOR=yes" > redis-init.env
printf "REDISCLI_AUTH=$2\n"
cat redis.env
cat docker.test
#mv docker.test docker-compose.yml