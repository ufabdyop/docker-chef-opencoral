TODO
===

* Create process supervisor structure (runit)
* Init coral user pass:

  mvn exec:java -Dexec.mainClass=edu.utah.nanofab.coralapi.examples.PasswordChange -Dexec.args="coral coral"

* runit

  cd /home/coral/coralapiserver/
  git pull origin master
  sudo ln -s /home/coral/coralapiserver/runit /etc/service/coralapiserver
  sudo /usr/sbin/runsvdir-start
