FROM bataeves/hadoop-base:2.0.0-hadoop2.10.1-java8

MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

ENV SPARK_VERSION=2.4.6
ENV PYTHONHASHSEED 1
ENV SPARK_HOME=/spark
ENV PATH=$SPARK_HOME/bin/:$PATH

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      python3 wget \
      && cd / \
      && wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-without-hadoop.tgz \
      && tar -xvzf spark-${SPARK_VERSION}-bin-without-hadoop.tgz \
      && mv spark-${SPARK_VERSION}-bin-without-hadoop spark \
      && rm spark-${SPARK_VERSION}-bin-without-hadoop.tgz \
      # https://www.programmersought.com/article/28284894598/
      && cp $HADOOP_HOME/share/hadoop/yarn/lib/jersey-core-1.9.jar $SPARK_HOME/jars/ \
      && cp $HADOOP_HOME/share/hadoop/yarn/lib/jersey-client-1.9.jar $SPARK_HOME/jars/

COPY spark-env.sh /spark/conf/spark-env.sh
