(defun opciones ()
  (terpri)
  (write-string "Buscar nombres que contengan
   0. Salir
   1. 'as'
   2. 'r' y 's' y 'a'
   3. 'za' o 'ca'
   Opción: ")
  (setq op (read))
  (if (not (eq op 0))
      (progn
        (buscar op)
        (opciones)
        )
    )
   (values)
)

(defun buscar (op)
  (setq check 0)
  (loop for N in nombres
       do (cond 
           ((eq op 1)
            (if (search "as" N)
                (progn
                  (write-line N)
                  (setq check 1)
                  )
              ))
           ((eq op 2)
            (if (and (search "a" N) (search "s" N) (search "r" N))
                 (progn
                  (write-line N)
                  (setq check 1)
                  )
             ))
           ((eq op 3)
            (if (or (search "za" N) (search "ca" N))
                (progn
                  (write-line N)
                  (setq check 1)
                  )
              ))
           (t
            (write-line "Solo opciones disponibles")
            (setq check -1)
            (return)
            )
           )
       )
  (if (= check 0)
      (write-line "No se encontraron coincidencias")
   )
  (values)
)

(setq nombres '(
"Aaron" 
"Abel" 
"Abelardo" 
"Adalberto" 
"Adela" 
"Adolfo" 
"Alan" 
"Alberto" 
"Alejandro" 
"Alfonso" 
"Alfredo" 
"Andrea" 
"Antonio" 
"Ariel" 
"Beatriz" 
"Belinda" 
"Benito" 
"Benjamin" 
"Berenice" 
"Blanca" 
"Bruno" 
"Cameron" 
"Camila" 
"Carla" 
"Carlos" 
"Carmen" 
"Carolina" 
"Catalina" 
"Cecilia" 
"Clara" 
"Claudia" 
"Cristian" 
"Daniel" 
"Eduardo" 
"Emilio" 
"Emily" 
"Eric" 
"Ernesto" 
"Fidel" 
"Francisco" 
"Gabriel" 
"Gabriela" 
"Gerardo" 
"Gladis" 
"Gloria" 
"Graciela" 
"Guadalupe" 
"Gustavo" 
"Helena" 
"Ignacio" 
"Jacklyn" 
"Jaquelin" 
"Jimena" 
"Joao" 
"Jordan" 
"Jorge" 
"Juan" 
"Laura" 
"Leonardo" 
"Leticia" 
"Linda" 
"Lorenzo" 
"Luis" 
"Manuel" 
"Mariano" 
"Mario" 
"Michelle" 
"Natalia" 
"Nichole" 
"Noel" 
"Norma" 
"Pablo" 
"Paloma" 
"Patricia" 
"Paula" 
"Paulina" 
"Paz" 
"Pedro" 
"Priscila" 
"Rafael" 
"Rebeca" 
"Regina" 
"Roberto" 
"Rodrigo" 
"Rosa" 
"Rosario" 
"Sabrina" 
"Said" 
"Salvador" 
"Samuel" 
"Sandra" 
"Santiago" 
"Sergio" 
"Sheila" 
"Sonia" 
"Susana" 
"Tatiana" 
"Teresa" 
"Victor" 
"Ximena"
))
