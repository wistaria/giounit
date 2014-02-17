#!/bin/sh

set -x

cat << EOF > sample_scan.in
256
EOF
cat sample_scan.in
rm -f sample_scan.out

export FORT10=sample_scan.out
export FORT11=sample_scan.in
export GIOUNIT_DEBUG=1

./sample_scan

cat sample_scan.out

rm -f sample_open.bin
export FORT10=sample_open.bin
export FORT11=sample_open.asc
export GIOUNIT_DEBUG=1

./sample_open1
./sample_open2
