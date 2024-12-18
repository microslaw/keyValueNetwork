server:
	redis-server config_startup/node1.conf > logs/node1.log &
	redis-server config_startup/node2.conf > logs/node2.log &
	redis-server config_startup/node3.conf > logs/node3.log &
	redis-server config_startup/node4.conf > logs/node4.log &
	redis-server config_startup/node5.conf > logs/node5.log &
	redis-server config_startup/node6.conf > logs/node6.log &
	redis-server config_startup/node7.conf > logs/node7.log &
	redis-server config_startup/node8.conf > logs/node8.log &
	redis-server config_startup/node9.conf > logs/node9.log &
	sleep 1

cluster:
	redis-cli --cluster create \
	127.0.0.1:6381 \
	127.0.0.1:6382 \
	127.0.0.1:6383 \
	127.0.0.1:6384 \
	127.0.0.1:6385 \
	127.0.0.1:6386 \
	127.0.0.1:6387 \
	127.0.0.1:6388 \
	127.0.0.1:6389 \
	--cluster-replicas 2

kill:
	-redis-cli -p 6381 cluster reset
	-redis-cli -p 6382 cluster reset
	-redis-cli -p 6383 cluster reset
	-redis-cli -p 6384 cluster reset
	-redis-cli -p 6385 cluster reset
	-redis-cli -p 6386 cluster reset
	-redis-cli -p 6387 cluster reset
	-redis-cli -p 6388 cluster reset
	-redis-cli -p 6389 cluster reset

	-redis-cli -p 6381 shutdown &
	-redis-cli -p 6382 shutdown &
	-redis-cli -p 6383 shutdown &
	-redis-cli -p 6384 shutdown &
	-redis-cli -p 6385 shutdown &
	-redis-cli -p 6386 shutdown &
	-redis-cli -p 6387 shutdown &
	-redis-cli -p 6388 shutdown &
	-redis-cli -p 6389 shutdown &

	rm config_cluster/*.conf

	sleep 1

cli:
	redis-cli -p 6381 -c

list:
	redis-cli -p 6381 cluster nodes

watch:
	watch -n 1 "date & curl 127.0.0.1:6389 --no-progress-meter"
