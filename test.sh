#!/bin/sh

set -x

cat << EOF > sample.in
256
EOF
cat sample.in
rm -f sample.out

export FORT10=sample.out
export FORT11=sample.in
export GIOUNIT_DEBUG=1

./sample

cat sample.out

