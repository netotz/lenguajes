(defun fibonacci (n)
  (if (or (zerop n) (= n 1))
    1
    (+ (fibonacci (- n 1)) (fibonacci (- n 2)))
    )
)

(defun inicio ()
  (format t "Ingresar segmento de molusco: ")
  (setq n (read))
  (format t "Ingresar diámetro: ")
  (setq d (read))
  (format t "Segmento~10tDiámetro~%")
  (calcular n d)
)

(defun calcular (seg diam)
  (if (zerop seg)
      nil
  (progn
    (format t "~,d~10t~,f~%" seg diam)
    (setq rel (/ (fibonacci seg) (fibonacci (- seg 1))))
    (setq newd (/ diam rel))
    (calcular (- seg 1) newd)
    )
  )
)
