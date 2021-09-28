#!/bin/bash

set -ex

# ./generate_docs.sh pete0emerson/terraform-aws-fake tutorials/fake fake v0.0.1

repo=$1
source=$2
name=$3
version=$4

rm -rf repos/$name
git clone --depth 1 --branch $version git@github.com:$repo.git repos/$name
mkdir -p content/$name
cp -R repos/$name/$source/* content/$name/

