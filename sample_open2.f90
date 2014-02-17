!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! giounit: gfortran utility for file and logical unit assginment
!
! Copyright (C) 2013-2014 by Synge Todo <wistaria@comp-phys.org>
!
! Distributed under the Boost Software License, Version 1.0. (See accompanying
! file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program sample
  implicit none
  real*8 a, b
  read(10) a
  read(11, *) b
  write(*,*) a
  write(*,*) b
end program sample
