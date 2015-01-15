TODO
===

* Fix DNS lookup of vagrant-coral-dev (https://github.com/docker/docker/issues/1951)
* Break install script into chunks
* Make recipe checkout develop branch of coral
* Create process supervisor structure (runit)
* Set up keys for passwordless ssh
* Store keys in cookbook using encryption from databags

Opencoral Recipe
---
* add to path:
		set profile_script [open /etc/profile a]
		puts $profile_script "pathmunge /sbin"
		puts $profile_script "pathmunge /usr/sbin"
		puts $profile_script "pathmunge /usr/local/sbin"
		puts $profile_script "pathmunge /usr/local/$javadir/bin"
		puts $profile_script "pathmunge $coraldir/bin"
		puts $profile_script "pathmunge $coraldir/sbin"
		puts $profile_script "unset pathmunge"
		puts $profile_script "unset i"

		close $profile_script
* #give coral sudo access
send_user "Giving coral sudo access\n"
exec echo "coral   ALL=(ALL)     ALL" >> /etc/sudoers
exec echo "root   ALL=(ALL)     ALL" >> /etc/sudoers

* configure coral properties:

	$filepath/config/site-instance.properties

* set up ports for CORBA, Debugging, apache

	#setting some rules for firewall
	#this is overly complicated for just inserting a line into a file, perl looks for first instance of dport 22, then adds a line to iptables
	set prefix "-A INPUT -m state --state NEW -m tcp -p tcp --dport "
	set suffix "-j ACCEPT"
	set firewall_port "5432"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "80"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50000"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50001"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50002"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50003"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50004"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50005"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50006"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50007"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50008"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50009"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50010"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50011"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50012"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50013"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50014"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"
	set firewall_port "50015"
	exec perl "-i" "-pe" "/A INPUT.*dport 22/ && (\$once ? \"\" : print \"$prefix $firewall_port $suffix\\n\") && \$once++" "/etc/sysconfig/iptables"

* dockerize opencoral startup

	send_user "Copying opencoral startup script to /etc/init.d\n"
