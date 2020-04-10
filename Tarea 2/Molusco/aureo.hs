main = do putStr "\nProporción áurea en concha de un molusco\n\n"
          nth <- validTerm
          diam <- validDiam
          putStrLn "\nSegmento\tDiámetro"
          calcular nth diam

validTerm = do  putStr "Introducir el segmento del molusco: "
                buff <- getLine
                if isInt buff
                        then (do let num = read buff :: Integer
                                 if num > 1
                                        then return (num)
                                        else (do putStrLn "\tSolo a partir del segmento 2"
                                                 validTerm
                                                )
                                )
                        else (do putStrLn "\tSolo números enteros positivos"
                                 validTerm
                                )

validDiam = do  putStr "Introducir diámetro del segmento: "
                buff <- getLine
                if isDbl buff
                        then (do let num = read buff :: Double
                                 if num > 0.0
                                        then return (num)
                                        else (do putStrLn "\tMedida inválida"
                                                 validDiam
                                                )
                                )
                        else (do putStrLn "\tSolo números"
                                 validDiam
                                )

calcular term diam =
        if term <= 0
                then return () 
                else (do putStr "  "
                         putStr . show $ term
                         putStr "\t\t"
                         print diam
                         let rel = (fibonacci term) / (fibonacci (term-1))
                         let ant_diam = diam / rel
                         calcular (term-1) ant_diam
                        )

fibonacci n =
        if n < 2 
                then 1
                else fibonacci (n-1) + fibonacci (n-2)

isInt :: String -> Bool
isInt str = case (reads str) :: [(Integer, String)] of
        [(_,"")] -> True
        _ -> False

isDbl :: String -> Bool
isDbl str = case (reads str) :: [(Double, String)] of
        [(_,"")] -> True
        _ -> False