TODO
===

* Create process supervisor structure (runit)
* Init coral user pass:

  mvn exec:java -Dexec.mainClass=edu.utah.nanofab.coralapi.examples.PasswordChange -Dexec.args="coral coral"

* runit

  sudo ln -s /home/coral/coralapiserver/runit /etc/service/coralapiserver
  sudo /usr/sbin/runsvdir-start
