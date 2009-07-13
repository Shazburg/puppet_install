#!/usr/bin/env bash
# setup.sh - Setup Puppet and Facter on a fresh install

packageList="ruby ruby-dev libruby libopenssl-ruby irb rdoc ri"
gemList="puppet facter"

echo "Installing ruby packages using apt-get... "
apt-get update &> /dev/null
apt-get install $packageList &> /dev/null
if [ $? -eq 1 ] ; then
	echo "Something broke. I quit."
	exit 1
else
	echo "done"
fi

mkdir -p $HOME/tmp/puppet
cd $HOME/tmp/puppet

echo "Downloading current RubyGems... "
curl -O http://rubyforge.org/frs/download.php/57643/rubygems-1.3.4.tgz &> /dev/null
if [ $? -eq 1 ] ; then
	echo "Something broke. I quit."
	exit 1
else
	echo "done"
fi

echo "Installing RubyGems... "
tar zxf rubygems-1.3.4.tgz &> /dev/null
cd rubygems-1.3.4
ruby setup.rb
if [ $? -eq 1 ] ; then
	echo "Something broke. I quit."
	exit 1
else
	echo "done"
fi

echo "Installing Puppet... "
gem install $gemList
if [ $? -eq 1 ] ; then
	echo "Something broke. I quit."
	exit 1
else
	echo "done"
fi

echo "Puppet successfully installed"

exit 0
