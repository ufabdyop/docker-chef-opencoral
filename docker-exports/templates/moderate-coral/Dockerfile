FROM ufabdyop/ubuntu-jdk-psql

RUN apt-get update && apt-get install -y rsync && \
    useradd -m coral && \
    mkdir -p /usr/local/coral && \
    mkdir -p /var/www/html/coral && \
    chown -R coral /usr/local/coral/ /var/www/html/ && \
    curl -k -L -o /var/www/html/NanoHTTPD.java https://raw.githubusercontent.com/saltlakeryan/nanohttpd/nanohttpd-for-java1.1/NanoHTTPD.java && \
    cd /var/www/html && javac NanoHTTPD.java

ADD data /data

RUN \
	rsync -rv /data/usr/local/coral/ /usr/local/coral/ && \
	rsync -rv /data/var/www/html/coral/ /var/www/html/coral/ && \
	chown -R coral:coral /usr/local/coral/ /var/www/html/coral/ && \
	chmod 755 /usr/local/coral/bin/ /usr/local/coral/sbin/ && \
	ln -s /usr/local/coral/share/IOR /var/www/html/IOR

ADD container-files/run.sh /run.sh
RUN chmod 755 /run.sh
CMD /run.sh
