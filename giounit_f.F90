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
