server:
	redis-server config_startup/master1.conf &
	redis-server config_startup/master2.conf &
	redis-server config_startup/master3.conf &
	redis-server config_startup/replica1a.conf &
	redis-server config_startup/replica1b.conf &
	redis-server config_startup/replica2a.conf &
	# redis-server config_startup/replica2b.conf &
	# redis-server config_startup/replica3a.conf &
	# redis-server config_startup/replica3b.conf &
	sleep 1

cluster:
	redis-cli --cluster create \
	127.0.0.1:6381 \
	127.0.0.1:6382 \
	127.0.0.1:6383 \
	127.0.0.1:6384 \
	127.0.0.1:6385 \
	127.0.0.1:6386 \
	--cluster-replicas 1
	# 127.0.0.1:6387 \
	# 127.0.0.1:6388 \
	# 127.0.0.1:6389 \

kill:
	-redis-cli -p 6381 cluster reset
	-redis-cli -p 6382 cluster reset
	-redis-cli -p 6383 cluster reset
	-redis-cli -p 6384 cluster reset
	-redis-cli -p 6385 cluster reset
	-redis-cli -p 6386 cluster reset
	# -redis-cli -p 6387 cluster reset
	# -redis-cli -p 6388 cluster reset
	# -redis-cli -p 6389 cluster reset

	-redis-cli -p 6381 shutdown &
	-redis-cli -p 6382 shutdown &
	-redis-cli -p 6383 shutdown &
	-redis-cli -p 6384 shutdown &
	-redis-cli -p 6385 shutdown &
	-redis-cli -p 6386 shutdown &
	# -redis-cli -p 6387 shutdown &
	# -redis-cli -p 6388 shutdown &
	# -redis-cli -p 6389 shutdown &

	# rm -rf ./appendonlydir
	rm config_cluster/*.conf

	sleep 1

cli:
	redis-cli -p 6381 -c

list:
	redis-cli -p 6381 cluster nodes


watch:
	watch -n 1 "date & curl 127.0.0.1:6389 --no-progress-meter"

