#!/bin/bash

set -e

# ./generate_docs.sh pete0emerson/terraform-aws-fake tutorials/fake fake v0.0.1

repo=$1
source=$2
name=$3
version=$4

#rm -rf repos/$name
#git clone --depth 1 --branch $version git@github.com:$repo.git repos/$name
#mkdir -p content/$name

# Naive approach
#cp -R repos/$name/$source/* content/$name/

function process_line() {
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

for file in $(find repos/$name/$source -type f -name "*.md") ; do
	dest=$(echo $file | sed "s#repos/$name/$source/#content/$name/#")
	echo "$file ==> $dest"
	cat $file | while read line ; do
		newline=$(process_line "$line")
		echo "Line: $newline"
	done
done
#* [Relative file link](../../examples/for-production/infrastructure-live/second.md)
#* [Relative path link](/examples/for-production/infrastructure-live/)
