FROM mysql/mysql-server:8.0.32

MAINTAINER gaoweixuan (breeze-cloud@foxmail.com)

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

COPY ./breeze.sql /docker-entrypoint-initdb.d

COPY ./breeze_config.sql /docker-entrypoint-initdb.d

COPY ./breeze_flowable.sql /docker-entrypoint-initdb.d

COPY ./breeze_quartz.sql /docker-entrypoint-initdb.d
