server:
	redis-server --port 6380 &

kill:
	redis-cli -p 6380 shutdown

cli:
	redis-cli -p 6380
