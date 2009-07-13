#!/usr/bin/env bash
# setup.sh - Setup Puppet and Facter on a fresh install

packageList="ruby ruby-dev libruby libopenssl-ruby irb rdoc ri"
gemList="puppet facter"


echo "Installing ruby packages using apt-get... "
apt-get -qq update
apt-get -qqq install $packageList
if [ $? -ne 0 ] ; then
	echo "Something broke. I quit."
	exit 1
else
	mkdir -p $HOME/tmp/puppet
	cd $HOME/tmp/puppet
	echo "done"
fi


echo "Downloading current RubyGems... "
wget http://rubyforge.org/frs/download.php/57643/rubygems-1.3.4.tgz &> /dev/null
if [ $? -ne 0 ] ; then
	echo "Something broke. I quit."
	exit 1
else
	echo "done"
fi


# Installing RubyGems...
tar zxf rubygems-1.3.4.tgz
cd rubygems-1.3.4
ruby setup.rb
if [ $? -ne 0 ] ; then
	echo "Something broke. I quit."
	exit 1
else
	ln -s /usr/bin/gem1.8 /usr/bin/gem
	echo "done"
fi


echo "Installing Puppet... "
gem install $gemList --no-rdoc --no-ri
if [ $? -ne 0 ] ; then
	echo "Something broke. I quit."
	exit 1
else
	puppetmasterd --mkusers
	pkill puppetmasterd

	(
	cat <<EOF
# site.pp
file { "/etc/sudoers":
	owner => root, group => root, mode => 440
}
EOF
	) > /etc/puppet/manifests/site.pp
	echo "done"
fi


echo "Puppet successfully installed"

exit 0
