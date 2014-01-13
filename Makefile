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

default: sample

sample: sample.o giounit_open.o giounit_helper.o
	$(F90) $(F90FLAGS) -o sample sample.o giounit_open.o giounit_helper.o $(CXXLIBS)

check: sample
	sh test.sh

distclean: clean
	rm -f sample

clean:
	rm -f *.o sample.in sample.out
