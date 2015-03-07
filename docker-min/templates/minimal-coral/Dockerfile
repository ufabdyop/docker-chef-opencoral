FROM peelsky/zulu-openjdk-busybox:7

RUN opkg-install rsync
RUN opkg-install bash
RUN adduser -D coral
RUN mkdir -p /usr/local/coral
RUN mkdir -p /var/www/html/coral
RUN chown -R coral /usr/local/coral/ /var/www/html/
RUN curl -k -L -o /var/www/html/NanoHTTPD.java https://raw.githubusercontent.com/saltlakeryan/nanohttpd/nanohttpd-for-java1.1/NanoHTTPD.java
RUN cd /var/www/html && javac NanoHTTPD.java

ADD data /data
ADD container-files/postinstall.sh /postinstall.sh
RUN chmod 755 /postinstall.sh
RUN /postinstall.sh

#cleanup
RUN ln -s /opt/zulu* /opt/jdk &&\
    rm -rf /opt/jdk/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/lib/plugin.jar \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so

RUN mkdir /usr/lib/jvm
RUN ln -s /opt/zulu* /usr/lib/jvm/default-java

ADD container-files/run.sh /run.sh
RUN chmod 755 /run.sh
CMD /run.sh
