DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t bataeves/hadoop-base:$(current_branch) ./base
	docker build -t bataeves/hadoop-namenode:$(current_branch) ./namenode
	docker build -t bataeves/hadoop-datanode:$(current_branch) ./datanode
	docker build -t bataeves/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t bataeves/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t bataeves/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t bataeves/hadoop-submit:$(current_branch) ./submit
	docker build -t bataeves/hadoop-spark:$(current_branch) ./spark

push:
	docker push bataeves/hadoop-base:$(current_branch)
	docker push bataeves/hadoop-namenode:$(current_branch)
	docker push bataeves/hadoop-datanode:$(current_branch)
	docker push bataeves/hadoop-resourcemanager:$(current_branch)
	docker push bataeves/hadoop-nodemanager:$(current_branch)
	docker push bataeves/hadoop-historyserver:$(current_branch)
	docker push bataeves/hadoop-submit:$(current_branch)
	docker push bataeves/hadoop-spark:$(current_branch)

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bataeves/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bataeves/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-2.10.1/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bataeves/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bataeves/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bataeves/hadoop-base:$(current_branch) hdfs dfs -rm -r /input
