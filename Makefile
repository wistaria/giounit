F90 = gfortran
F90FLAGS = -O2

CXX = g++
CXXFLAGS = -O2
CXXLIBS = -lstdc++

.SUFFIXES:
.SUFFIXES: .o .f90 .F90 .C

.f90.o:
	$(F90) $(F90FLAGS) -c $<

.F90.o:
	$(F90) $(F90FLAGS) -c $<

.C.o:
	$(CXX) $(CXXFLAGS) -c $<

default: sample

sample: sample.o giounit_f.o giounit_cxx.o
	$(F90) $(F90FLAGS) -o sample sample.o giounit_f.o giounit_cxx.o $(CXXLIBS)

check: sample
	sh test.sh

distclean: clean
	rm -f sample

clean:
	rm -f *.o sample.in sample.out
