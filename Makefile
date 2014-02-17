##############################################################################
#
# giounit: gfortran utility for file and logical unit assginment
#
# Copyright (C) 2013-2014 by Synge Todo <wistaria@comp-phys.org>
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#
##############################################################################

F90 = gfortran
F90FLAGS = -O2

CXX = g++
CXXFLAGS = -O2
CXXLIBS = -lstdc++

.SUFFIXES:
.SUFFIXES: .o .f90 .F90 .C

.f90.o .F90.o:
	$(F90) $(F90FLAGS) -c $<

.C.o:
	$(CXX) $(CXXFLAGS) -c $<

default: sample_scan sample_open1 sample_open2

giounit_scan.o: giounit.h
giounit_open.o: giounit.h

sample_scan: sample_scan.o giounit_util.o giounit_scan.o
	$(F90) $(F90FLAGS) -o sample_scan sample_scan.o giounit_util.o giounit_scan.o $(CXXLIBS)

sample_open1: sample_open1.o giounit_util.o giounit_open.o
	$(F90) $(F90FLAGS) -o sample_open1 sample_open1.o giounit_util.o giounit_open.o $(CXXLIBS)

sample_open2: sample_open2.o giounit_util.o giounit_open.o
	$(F90) $(F90FLAGS) -o sample_open2 sample_open2.o giounit_util.o giounit_open.o $(CXXLIBS)

check: sample_scan sample_open1 sample_open2
	sh test.sh

distclean: clean
	rm -f sample_scan sample_open1 sample_open2

clean:
	rm -f *.o sample_scan.in sample_scan.out sample_open.bin sample_open.asc
