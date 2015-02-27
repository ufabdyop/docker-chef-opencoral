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

* Add a recipe:

mkdir -p chef/active-cookbook/to-merge/opencoral/files/default/
mkdir -p chef/active-cookbook/to-merge/opencoral/recipes
