#setting up folder directories
##mkdir redis0{1..3}-master
##mkdir redis0{1..3}-master/conf
##mkdir log
##mkdir log/redis0{1..3}-master/
##touch log/redis0{1..3}-master/redis.log
##mkdir redis0{1..3}-slave
##mkdir redis0{1..3}-slave/conf
##mkdir log/redis0{1..3}-slave/
##touch log/redis0{1..3}-slave/redis.log
##docker network create --gateway 173.17.0.1 --subnet 173.17.0.0/16 redis_app_net
# Creatind docker compose file
echo "version: '2'\nservices:"