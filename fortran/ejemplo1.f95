program example1
	implicit none
	integer :: i
    real, dimension(10) :: in, out

	open(1, file = "datos.dat", status = 'new')
	do i = 1, 10
    	write(1,*) (i*2)**2
	end do
    close(1)

    open(2, file = "datos.dat", status = 'old')
    
    do i = 1, 10
      read(2,*) out(i)
    end do
    close(2)
    do i = 1, 10
      write(*,*) out(i)
    end do
end program example1