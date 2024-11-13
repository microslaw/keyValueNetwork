server:
	redis-server --port 6380 &

kill:
	redis-cli -p 6380 shutdown

cli:
	redi-cli -p 6380
