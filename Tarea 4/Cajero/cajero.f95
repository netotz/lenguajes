program cajero
    implicit none
       logical, external :: menu
    do
        if (.not. menu() ) then
          exit
        end if
    end do
end program cajero

logical function menu ()
    implicit none
    real, external :: contarDinero, number
    integer, external :: divisas
    logical, external :: isNum
    real :: mxn, uzs
    integer :: opcion
    character(len = 256) :: input
    integer, dimension(6) :: valoresMXN
    integer, dimension(13) :: valoresUZS
    valoresMXN = (/20,50,100,200,500,1000 /)
    valoresUZS = (/1,3,5,10,25,50,100,200,500,1000,5000,10000,50000 /)
    
    menu = .true.
    opcion = 0
    mxn = 0
    uzs = 0
    
    call system('cls')
    print *, char(9), "CAJERO MXN <-> UZS"
    print *, char(9), "$1 MXN = 421.89998439 UZS"
    print *, ''
    
    mxn = contarDinero("mxn.dat", 6, valoresMXN)
    uzs = contarDinero("uzs.dat", 13, valoresUZS)

    print *, char(9), "Cantidad de dinero disponible: "
    write(*,fmt = '(2a,f15.0,a)') char(9),"$ ",mxn," MXN"
    write(*,fmt = '(2a,f15.0,a)') char(9),"  ",uzs," UZS"
    print*,''
    
    print *, char(9),"1. Retirar dinero"
    print *, char(9),"2. Depositar dinero"
    print *, char(9),"3. Consultar billetes disponibles"
    print *, char(9),"0. Salir"
    write(*,fmt = '(2a)',advance = 'no')char(9),"Opcion: "
    read *, input
    if (isNum(input)) then
        opcion = number(trim(input))
    else
        opcion = 4
    end if

    select case (opcion)
        case (1)
            if (mxn <= 0 .and. uzs <= 0) then
                print *, char(9), "No hay dinero. Intente depositar."
                call system('pause')
            else
                call accion("retirar", mxn, uzs)
            end if
        case (2)
            call accion("depositar", mxn, uzs)
        case (3)
            call system('cls')
            if (divisas() == 1) then
                call consultarBilletes("mxn.dat", 6, valoresMXN)
            else
                call consultarBilletes("uzs.dat", 13, valoresUZS)
            end if
        case (0)
            menu = .false.
        case default
            print*, char(9), "Solo opciones disponibles"
            call system('pause')
    end select
end function menu

real function contarDinero (archivo, n, valores)
    implicit none
    integer, intent(in) :: n
    character(len = *), intent(in) :: archivo
    integer, dimension(n), intent(in) :: valores
    integer, dimension(n) :: billetes
    integer :: i
    logical :: existe
    existe = .false.
    contarDinero = 0
    i = 0

    inquire(file = archivo, exist = existe)
    if (existe) then
        open(40, file = archivo, status = "read")
        do i = 1, n
            read(40,*) billetes(i)
            contarDinero = contarDinero + ( billetes(i) * valores(i) )
        end do
        close(40)
    else
        open(41, file = archivo, status = "new")
        do i = 1, n
            write(41,*) 0
        end do
        close(41)
        contarDinero = 0
    end if
end function contarDinero

integer function divisas()
    implicit none
    integer :: opcion
    logical, external :: isNum
    real, external :: number
    character(len = 256) :: input
    character(len = *), parameter :: titulo = "Eleccion de divisa"
    opcion = 0
    do
        call system('cls')
        print *, char(9), titulo
        call separador( 2 * len(titulo) )
        print *, "Escoger moneda:"
        print *, char(9),"1. Peso mexicano (MXN)"
        print *, char(9),"2. Som uzbeko (UZS)"
        write(*,fmt = '(2a)',advance = 'no')char(9),"Opcion: "
        read *, input
        if (isNum(input)) then
            opcion = number(trim(input))
        else
            opcion = 0
        end if

        if (opcion /= 1 .and. opcion /= 2) then
            print *, char(9), "Solo seleccionar opciones disponibles"
            call system('pause')
        else
            divisas = opcion
            exit
        end if
    end do
end function divisas

subroutine accion (tipo, mxn, uzs)
    implicit none
    character(len = *), intent(in) :: tipo
    real, intent(in) :: mxn, uzs
    real :: cantidad
    integer, external :: divisas
    real, external :: validAmountMXN, validAmountUZS, number
    logical, external :: isNum
    integer :: opcion
    character(len = 50) :: titulo
    character(len = 256) :: input
    
    titulo = trim(tipo // " dinero")
    opcion = 0
    cantidad = 0   
134 opcion = divisas()
    if (opcion == 1 .and. tipo .eq. "retirar" .and. mxn <= 0) then
        print *, char(9),"Lo sentimos, no hay pesos mexicanos (MXN)."
        call system('pause')
        go to 134
    else if (opcion == 2 .and. tipo .eq. "retirar" .and. uzs <= 0) then
        print *, char(9),"Lo sentimos, no hay som uzbekos (UZS)."
        call system('pause')
        go to 134
    end if

    do
        call system('cls')
        print*, char(9), titulo
        call separador(2 * len(titulo))
        write(*,fmt = '(4a)',advance = 'no') char(9), "Ingresar cantidad a ", tipo, ": "
        read *, input
        if ( isNum(input) ) then
            cantidad = number(input)
        else
            print *, char(9), "Favor de introducir un valor numerico."
            call system('pause')
            cycle
        endif
        if (opcion == 1) then !mxn
            if (tipo .eq. "retirar" .and. cantidad > mxn) then
                write(*,'(2a,f0.0,a)') char(9), "No puede retirar mas dinero del que actualmente hay ($",mxn," MXN)."
            else
                if (cantidad >= 20) then
                    cantidad = validAmountMXN(cantidad)
                    call generarBilletesMXN(cantidad, tipo, mxn, uzs, .true.)
                    exit
                else
                    print*, char(9),"No es posible procesar cantidades menores a $20,"
                    print*, char(9),"debido a que es el billete de menor valor en MXN."
                end if
            end if
        else    !uzs
            if (tipo .eq. "retirar" .and. cantidad > uzs) then
                write(*,'(2a,f0.0,a)') char(9), "No puede retirar mas dinero del que actualmente hay ($",uzs," UZS)."
            else
                if (cantidad >= 1) then
                    cantidad = validAmountUZS(cantidad)
                    call generarBilletesUZS(cantidad, tipo, mxn, uzs, .true.)
                    exit
                else
                    print*, char(9),"No es posible procesar cantidades menores a 1,"
                    print*, char(9),"debido a que es el billete de menor valor en UZS."
                end if
            end if
        end if
        call system('pause')
    end do
end subroutine accion

subroutine consultarBilletes (archivo, n, valores)
    implicit none
    character(len = *), intent(in) :: archivo
    integer, intent(in) :: n
    integer, dimension(n), intent(in) :: valores
    integer :: i
    integer, dimension(n) :: billetes

    i = 0

    open(30, file = archivo, status = "read")
    do i = 1, n
        read(30,*) billetes(i)
    end do
    close(30)

    print*,''
    print *, "Billetes disponibles:"
    write(*,fmt = '(a,a5,a14)') char(9),"Valor","Cantidad"
    do i = 1, n
        if (n == 6) then
            write(*,fmt = '(2a,i4,i15)') char(9),"$",valores(i), billetes(i)
        else
              write(*,fmt = '(a,i5,i15)') char(9),valores(i), billetes(i)
        end if
    end do
    print*,''
    call system('pause')
end subroutine consultarBilletes

subroutine generarBilletesMXN (total, tipo, mxn, uzs, siguiente)
    implicit none
    real, intent(in) :: total, mxn, uzs
    character(len = *), intent(in) :: tipo
    logical, intent(in) :: siguiente
    integer, external :: menorBillete
    real, external :: validAmountUZS
    character(len = 256) :: opcion
    real :: rest, suma
    integer :: menor, rep, i, j, looped
    integer, dimension(6) :: valores, viejos, nuevos, billetes
    logical :: cero
    valores = (/20,50,100,200,500,1000 /)
    nuevos = (/0,0,0,0,0,0 /)

    rest = total
    menor = menorBillete(total)
    rep = 1
    i = 0
    j = 0
    cero = .false.

    if (tipo .eq. "retirar") then
        open(25, file = "mxn.dat", status = "read")
        do i = 1, 6
            read(25,*) viejos(i)
        end do
        close(25)

        if (total == mxn) then
            billetes = nuevos
            go to 111
        endif
    else
        viejos = (/2000000000,2000000000,2000000000,2000000000,2000000000,2000000000 /)
    end if
    go to 112
112 rest = total
    billetes = viejos
    cero = .false.

    do i = 1, 6
        if (valores(i) == menor) then
            do j = 1, rep
                if (billetes(i) > 0) then
                    billetes(i) = billetes(i) - 1
                    rest = rest - valores(i)
                    if (rest <= 0) then
                        go to 111
                    end if
                else
                    cero = .true.
                    looped = 1
                    exit
                end if
            end do
            exit
        end if
        
        if (cero) then
            exit
        endif
    end do
    
    do
        if (.not. cero) then
            looped = 1
            do i = 1, 6
                if ( rest >= valores(i) ) then
                    looped = 2
                    if (billetes(i) > 0) then
                        looped = 0
                        billetes(i) = billetes(i) - 1
                        rest = rest - valores(i)
                        if (rest <= 0) then
                            go to 111
                        end if
                    end if
                else
                    exit
                end if
            end do
        endif

        select case (looped)
            case (2)
                rep = rep + 1
                go to 112
            case (1)
                go to 113
            case (0)
                cycle
        end select
    end do

111 suma = 0
    do i = 1, 6
        nuevos(i) = viejos(i) - billetes(i)
        suma = suma + ( nuevos(i) * valores(i) )
    end do

    if (suma /= total) then
        go to 113
    end if

    print*,''
    print *, char(9),"Billetes procesados:"
       do i = 1, 6
        if (nuevos(i) /= 0) then
            write(*,fmt = '(i15,a,i4)') nuevos(i)," billetes de $",valores(i)
        end if
    end do

    print*,''
    write(*,fmt = '(4a)', advance = 'no') char(9),"Se ", tipo, "on " 
    write(*,'(a,f0.2,a)', advance = 'no') "$", suma, " MXN "
    write(*,*) "con exito."
    call system('pause')

    call guardarBilletes(nuevos, tipo, "mxn.dat", 6)
    return

113 do i = 1, 6
        if (valores(i) == menor) then
            do j = i + 1, 6
                if ( total >= valores(j) ) then
                    if (billetes(j) > 0) then
                        menor = valores(j)
                        rep = 1
                        go to 112
                    else
                        cycle
                    end if
                else
                    exit
                endif
            enddo
        endif
    enddo

    if (siguiente) then
        rest = total * 421.89998439
        print*, char(9), "Debido a la falta de billetes MXN,"
        write(*,'(2a,f0.3,a)') char(9), "su cambio se procesara en UZS (",rest,")."
        do
            write(*,'(2a)', advance = 'no') char(9),"Aceptar y continuar (S/N)? "
            read *, opcion
            if (opcion .eq. "n" .or. opcion .eq. "N") then
                go to 114
            else if (opcion .eq. "s" .or. opcion .eq. "S") then
                rest = validAmountUZS(rest)
                call generarBilletesUZS(rest, tipo, mxn, uzs, .false.)
                go to 114
            endif
        enddo
    else
        print*, char(10),char(9), "Debido a la falta de billetes de ambas monedas, no podemos procesar su retiro."
        call system('pause')
    endif

114 return
end subroutine generarBilletesMXN

subroutine generarBilletesUZS(total, tipo, mxn, uzs, siguiente)
    implicit none
    real, intent(in) :: total, uzs, mxn
    character(len = *), intent(in) :: tipo
    logical, intent(in) :: siguiente
    real, external :: validAmountMXN
    character(len = 256) :: opcion
    real :: rest, suma
    integer :: menor, rep, i, j, looped
    integer, dimension(13) :: valores, viejos, nuevos, billetes
    logical :: cero
    valores = (/1,3,5,10,25,50,100,200,500,1000,5000,10000,50000 /)
    nuevos = (/0,0,0,0,0,0,0,0,0,0,0,0,0 /)

    rest = total
    menor = 1
    rep = 1
    i = 0
    j = 0
    cero = .false.

    if (tipo .eq. "retirar") then
        open(26, file = "uzs.dat", status = "read")
        do i = 1, 13
            read(26,*) viejos(i)
        end do
        close(26)

        if (total == uzs) then
            billetes = nuevos
            go to 312
        endif
    else
        viejos = (/9999999,9999999,9999999,9999999,9999999,9999999,9999999,9999999,9999999,9999999,9999999,9999999,9999999 /)
    end if

311 rest = total
    billetes = viejos
    cero = .false.

    do i = 1, 13
        if (valores(i) == menor) then
            do j = 1, rep
                if (billetes(i) > 0) then
                    billetes(i) = billetes(i) - 1
                    rest = rest - valores(i)
                    if (rest <= 0) then
                        go to 312
                    end if
                else
                    cero = .true.
                    looped = 1
                    exit
                end if
            end do
            exit
        end if
        
        if (cero) then
            exit
        endif
    end do
    
    do
        if (.not. cero) then
            looped = 1
            do i = 1, 13
                if ( rest >= valores(i) ) then
                    looped = 2
                    if (billetes(i) > 0) then
                        looped = 0
                        billetes(i) = billetes(i) - 1
                        rest = rest - valores(i)
                        if (rest <= 0) then
                            go to 312
                        end if
                    end if
                else
                    exit
                end if
            end do
        endif

        select case (looped)
            case (2)
                rep = rep + 1
                go to 311
            case (1)
                go to 313
            case (0)
                cycle
        end select
    end do

312 suma = 0
    do i = 1, 13
        nuevos(i) = viejos(i) - billetes(i)
        suma = suma + ( nuevos(i) * valores(i) )
    end do

    if (suma /= total) then
        go to 313
    end if

    print*,''
    print *, char(9),"Billetes procesados:"
       do i = 1, 13
        if (nuevos(i) /= 0) then
            write(*,fmt = '(i15,a,i5)') nuevos(i)," billetes de ",valores(i)
        end if
    end do

    print*,''
    write(*,fmt = '(4a)', advance = 'no') char(9),"Se ", tipo, "on " 
    write(*,'(a,f0.2,a)', advance = 'no') " ", suma, " UZS "
    write(*,*) "con exito."
    call system('pause')

    call guardarBilletes (nuevos, tipo, "uzs.dat", 13)
    return

313 do i = 1, 13
        if (valores(i) == menor) then
            do j = i + 1, 6
                if ( total >= valores(j) ) then
                    if (billetes(j) > 0) then
                        menor = valores(j)
                        rep = 1
                        go to 311
                    else
                        cycle
                    end if
                else
                    exit
                endif
            enddo
        endif
    enddo
    
    if (siguiente) then
        rest = total / 421.89998439
        print*, char(9), "Debido a la falta de billetes UZS,"
        write(*,'(2a,f0.3,a)') char(9), "su cambio se procesara en MXN (",rest,")."
        do
            write(*,'(2a)', advance = 'no') char(9),"Aceptar y continuar (S/N)? "
            read *, opcion
            if (opcion .eq. "n" .or. opcion .eq. "N") then
                go to 314
            else if (opcion .eq. "s" .or. opcion .eq. "S") then
                rest = validAmountMXN(rest)
                call generarBilletesMXN(rest, tipo, mxn, uzs, .false.)
                go to 314
            endif
        enddo
    else
        print*, char(10),char(9), "Debido a la falta de billetes de ambas monedas, no podemos procesar su retiro."
        call system('pause')
    endif

314 return
end subroutine generarBilletesUZS

subroutine guardarBilletes (nuevos, tipo, archivo, n)
    implicit none
    integer, dimension(n), intent(in) :: nuevos
    character(len = *), intent(in) :: tipo, archivo
    integer, intent(in) :: n
    integer, dimension(n) :: viejos, operacion
    integer :: i

    i = 0

    open(21, file = archivo, status = "read")
    do i = 1, n
        read(21,*) viejos(i)
    end do
    close(21)

    open(20, file = archivo, status = "replace")
    do i = 1, n
          if (tipo .eq. "retirar") then
            operacion(i) = viejos(i) - nuevos(i)
        else
            operacion(i) = viejos(i) + nuevos(i)
        end if
        write(20,*) operacion(i)
    end do
    close(20)
end subroutine guardarBilletes

real function validAmountMXN(amount)
    implicit none
    real, intent(in) :: amount
    integer :: i
    real :: menor
    real, dimension(4) :: modulos
    
    i = 0
    menor = 50
    modulos(1) = amod(amount, 20.0)
    if (amount >= 20) then
        modulos(2) = amod(amount - 20, 50.0)
    else
        modulos(2) = 50
    endif
    modulos(3) = amod(amount, 50.0)
    if (amount >= 50) then
        modulos(4) = amod(amount - 50, 20.0)
    else
          modulos(4) = 50
    end if
    
    do i = 1, 4
        if (modulos(i) < menor) then
            menor = modulos(i)
           end if
     end do
    if (menor == 0) then
          validAmountMXN = amount
    else
          print*,''
        write(*,fmt = '(2a,f0.3,a)') char(9),"La cantidad de $",menor," no podra ser procesada,"
        write(*,*) char(9),"debido a que es menor que el billete de valor mas bajo ($20 MXN)."
        validAmountMXN = amount - menor
    end if
end function validAmountMXN

real function validAmountUZS(amount)
    implicit none
    real, intent(in) :: amount
    real :: modulo
    modulo = amod(amount, 1.0)

    if (modulo == 0) then
        validAmountUZS = amount
    else
        print*,''
        write(*,fmt = '(2a,f0.3,a)') char(9), "La cantidad de ",modulo," no podra ser procesada,"
        print*, char(9), "debido a que es menor que el billete de valor mas bajo (1 UZS)."
        validAmountUZS = amount - modulo
    end if
end function validAmountUZS

integer function menorBillete(amount)
    implicit none
    real, intent(in) :: amount
    real, dimension(4) :: modulos
    
    modulos(1) = amod(amount, 20.0)
    modulos(2) = amod(amount - 20, 50.0)
    modulos(3) = amod(amount, 50.0)
    modulos(4) = amod(amount - 50, 20.0)
    
    if (modulos(1) == 0.0 .or. modulos(2) == 0.0) then
          menorBillete = 20
     else if (modulos(3) == 0.0 .or. modulos(4) == 0.0) then
        menorBillete = 50
      end if
end function menorBillete

subroutine separador (n)
    implicit none
    integer, intent(in) :: n
    integer :: i

    do i = 1, n
        write(*,'(a)',advance = 'no') char(196)
    end do
    print*,''
end subroutine separador

logical function isNum (string)
    implicit none
    character(len = *), intent(in) :: string
    integer :: error
    real :: numero

    error = 0
    numero = 0

    read (string, *, iostat = error) numero
    isNum = error == 0
end function isNum

real function number(string)
    implicit none
    character(len = *), intent(in) :: string
    integer :: stat
    real :: numero
    read(string,*,iostat = stat) numero
    number = numero
end function number
