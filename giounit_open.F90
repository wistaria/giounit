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

#ifdef __GFORTRAN__

subroutine giounit_open(unit, len, path) bind(C)
  use iso_c_binding
  implicit none
  integer(c_int), intent(in), value :: unit, len
  character(kind=c_char), intent(in) :: path(*)
  integer :: i
  character(len=256) :: p
  do i = 1, len
     p(i:i) = path(i)
  end do
  open(unit, file=p(1:len))
end subroutine giounit_open

subroutine giounit_close(unit) bind(C)
  use iso_c_binding
  implicit none
  integer(c_int), intent(in), value :: unit
  close(unit)
end subroutine giounit_close

#endif
