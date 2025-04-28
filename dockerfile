# jdk基础镜像
FROM bisheng-jdk-1.8:v1.0

# 打包人
MAINTAINER "heli"

# 定义数据卷，默认挂载到/tmp目 录
VOLUME /tmp

# 应用jar文件,可以由外部jenkins传入
ARG JAR_FILE_PATH=/target

# 定义变量//
ENV APP_HOME=/
ENV LANG C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV JAVA_OPTS "-Xms256M -Xmx256M -Xmn128M -Xss512k -XX:+UseG1GC"
#ENV ACTIVE="prod"

# 定义工作目录
WORKDIR $APP_HOME

RUN mkdir /data/app/logs -p
# 拷贝应用JAR文件到容器中
ADD $JAR_FILE_PATH/*.jar $APP_HOME/app.jar


EXPOSE 8080

# 执行命令
# --spring.profiles.active=$ACTIVE"
CMD ["sh", "-c", "/data/jdk/bisheng-jdk1.8.0_422/bin/java $JAVA_OPTS -jar $APP_HOME/app.jar"]
