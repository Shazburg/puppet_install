#!/usr/bin/env bash
# setup.sh - Setup Puppet and Facter on a fresh install

rubyPackages="ruby ruby-dev irb rdoc ri"
puppetPackages="puppet"
facterPackages="facter"

testPackages ()
{
	filenames="$@"
	for filename in $filenames
	do
		echo "Testing $filename"
		if which $filename &> /dev/null ; then
			echo "$filename is already installed. It's proper setup is your problem."
		else
			echo "$filename is not installed. I will install it."
			echo $filename >> .must_install
		fi
	done
}

cleanup ()
{
	rm -f .must_install
}

setup ()
{
	testPackages ruby puppet facter
	cleanup
}

setup
