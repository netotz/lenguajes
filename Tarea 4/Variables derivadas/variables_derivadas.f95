module tipos
    implicit none
    type :: proton
        real :: m = 1.6726E-27
        real :: q = 1.6021E-19
    end type proton

    type :: neutron
        real :: m = 1.67492E-27
        real :: q = 0
    end type neutron

    type :: electron
        real :: m = 9.10938E-31
        real :: q = -1.6021E-19
    end type electron

    type :: atomo
        type(proton) :: Protones
        type(neutron) :: Neutrones
        type(electron) :: Electrones
        real :: m
        logical :: estable
    end type atomo
end module tipos

program particulas
    implicit none
    call system('cls')
    call main
end program particulas

subroutine main()
    use tipos
    implicit none
    integer(kind = 7), external :: leer
    type(atomo) :: Atom
    integer(kind = 7) :: cantidad
    real :: carga
    Atom%m = 0
    carga = 0

    print *, "Propiedades basicas de un atomo"
    print *, ''
    cantidad = leer("protones")
    Atom%m = Atom%m + (cantidad * Atom%Protones%m)
    carga = carga + (cantidad * Atom%Protones%q)

    cantidad = leer("neutrones")
    Atom%m = Atom%m + (cantidad * Atom%Neutrones%m)
    carga = carga + (cantidad * Atom%Neutrones%q)

    cantidad = leer("electrones")
    Atom%m = Atom%m + (cantidad * Atom%Electrones%m)
    carga = carga + (cantidad * Atom%Electrones%q)

    Atom%m = Atom%m / 1.660538921E-27

    print*,''
    write(*,'(a,f0.5,a)') "Masa del atomo: ", Atom%m, " u"

    write(*,'(a)', advance = 'no') "El atomo "
    if (carga == 0) then
        write (*,'(a)', advance = 'no') "no "
    endif
    write(*,'(a)', advance = 'no') "es un isotopo "

    if (carga > 0) then
        print *, "(positivo)."
    else if (carga < 0) then
        print *, "(negativo)."
    endif
    print*,''
    call system('pause')
end subroutine main

recursive function leer (palabra) result (cantidad)
    implicit none
    character (len = *), intent(in) :: palabra
    integer, external :: entero
    logical, external :: isNum
    character (len = 256) :: input
    integer (kind = 7) :: cantidad
    do
        write(*,'(3a)', advance = 'no') "Ingresar cantidad de ", palabra, ": "
        read *, input

        if (isNum(input)) then
            cantidad = entero(trim(input))
            exit
        else
            print *, char(9),"Solo se permiten numeros enteros."
        endif
    enddo
end function leer

logical function isNum (string)
    implicit none
    character(len = *), intent(in) :: string
    integer :: error, numero
    error = 0
    numero = 0

    read (string, *, iostat = error) numero
    isNum = error == 0
end function isNum

integer function entero(string)
    implicit none
    character(len = *), intent(in) :: string
    integer :: stat, numero
    stat = 0
    numero = 0

    read(string,*,iostat = stat) numero
    entero = numero
end function entero