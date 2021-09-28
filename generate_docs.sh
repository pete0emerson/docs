#!/bin/bash

set -e

# ./generate_docs.sh pete0emerson/terraform-aws-fake tutorials/fake fake v0.0.3

repo=$1
source=$2
name=$3
version=$4

rm -rf repos/$name
git clone --depth 1 --branch $version git@github.com:$repo.git repos/$name
rm -rf content/$name/$version
mkdir -p content/$name/$version

# Get everything in there, we'll replace markdown later (Naive approach)
cp -R repos/$name/$source/* content/$name/$version

function DEAD_process_line() {
	local line=$1
	echo "$line" | grep '\[.*\]\(.*\)' > /dev/null
	if [[ $? -eq 0 ]] ; then
		p=$(echo "$line" | sed -E "s#\[.*]\((.*))#\1#")
		n=$(echo "$p" | sed 's#../../##')
		if [[ "$p" != "$n" ]] ; then
			echo "$n"
			echo "YO $line" | sed -E "s#(.*)\[.*]\()(.*)(\).*)(.*)#$n#"
		else
			echo "match $line"
		fi
	else
		echo "NOMATCH $line"
	fi
}

function process_line() {
	local line=$1
	echo "$line" | grep '^include::' > /dev/null 2>&1
	if [[ $? -eq 0 ]] ; then
		file=$(echo "$line" | sed 's/^include:://')
		echo "$file" | grep '\[[0-9]*..[0-9]*\]' > /dev/null 2>&1
		if [[ $? -eq 0 ]] ; then
			f=$(echo "$file" | sed 's/\[.*//')
			start=$(echo "$file" | cut -d \[ -f 2 | cut -d . -f 1)
			end=$(echo "$file" | cut -d \[ -f 2 | cut -d . -f 3 | sed 's/]//')
			let diff=$end-$start+1
			cat $f | head -n $end | tail -n $diff
		else
			cat $file
		fi
	else
		echo "$line"
	fi
}

for file in $(find repos/$name/$source -type f -name "*.md") ; do
	dest=$(echo $file | sed "s#repos/$name/$source/#content/$name/$version/#")
	destdir=$(dirname $dest)
	mkdir -p $destdir
	touch $dest
	dirname=$(dirname $file)
	basename=$(basename $file)
	rm -f $dest
	cd $dirname
	>&2 echo "$dirname --> $basename ==> $dest"
	cat $basename | while read line ; do
		newline=$(process_line "$line")
		cd - > /dev/null 2>&1 
		echo "$newline" >> $dest
		cd $dirname
	done
	cd - > /dev/null 2>&1
done
