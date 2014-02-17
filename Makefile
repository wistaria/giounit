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

default: sample_scan

giounit_scanner.o: giounit.h
giounit_helper.o: giounit.h

sample_scan: sample_scan.o giounit_util.o giounit_scan.o
	$(F90) $(F90FLAGS) -o sample_scan sample_scan.o giounit_util.o giounit_scan.o $(CXXLIBS)

check: sample_scan
	sh test.sh

distclean: clean
	rm -f sample_scan

clean:
	rm -f *.o sample_scan.in sample_scan.out
