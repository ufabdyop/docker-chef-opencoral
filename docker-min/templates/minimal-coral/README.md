Build
---
docker build -t jbox .

Run
---
Assuming a db container is running called pg:

docker rm -f cjbox; docker run --name cjbox -d \
	-v /tmp/coralData:/data \
	-v /tmp/coralLog:/var/log/coral \
	--link pg:coraldb \
	-e CORALSERVER=mycoralservername.local \
	-p 50000:50000 \
	-p 50001:50001 \
	-p 50002:50002 \
	-p 50003:50003 \
	-p 50004:50004 \
	-p 50005:50005 \
	-p 50006:50006 \
	-p 50007:50007 \
	-p 50008:50008 \
	-p 50009:50009 \
	-p 50010:50010 \
	-p 50011:50011 \
	-p 80:80 \
	jbox \
	/postinstall.sh
