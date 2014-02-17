Giounit
=======

Giounit is a gfortran utility for supporting file and logical unit
assginment by using environment variables, e.g. FORT10.

Usage
=====

1. Choose a strategy, 'scan' or 'open'.  If all of your files are
   'formatted', please choose 'scan,' otherwise 'open' strategy should
   be used.

2. Prepare a C++ source file for opening and closing files.  For the
   'scan' strategy, giounit_scan.C is the file you need.  For the
   latter strategy, you have to specify all the unit in the source
   file as demonstrated in giounit_open.C.

3. Compile and link the above C++ file and giounit_util.F90 to your program.

Test
====

make check
