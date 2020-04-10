(defvar *db* nil)

(defun add_book (title author genre year country)
  (list :t�tulo title :autor author :g�nero genre :a�o year :pa�s country)
)

(defun add_rec (book)
  (push book *db*)
)

(defun print_db (BD)
    (format t "~{~%~{~a:~9t~a~%~}~}" BD)
    (values)
)

(defun read_line (txt)
  (format *query-io* "~a: " txt)
  (force-output *query-io*)
  (read-line *query-io*)
)

(defun read_rec ()
  (format t "~%")
  (add_book
   (read_line "T�tulo")
   (read_line "Autor")
   (read_line "G�nero")
   (or (parse-integer (read_line "A�o") :junk-allowed t) "Desconocido")
   (read_line "Pa�s")
  )
)

(defun fill_db ()
  (loop (add_rec (read_rec))
        (unless (y-or-n-p "�Agregar otro libro?")
          (when (y-or-n-p "�Mostrar base de datos?")
            (print_db *db*)
            (return)
            )
	  (return)
          )
    )
   (values)
)

(defun save_db (filename)
  (with-open-file
      (out filename 
	:direction :output 
	:if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out)
     )
   )
   (format t "Base de datos guardada con �xito.")
   (values)
)

(defun load_db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in))
     )
   )
   (print_db *db*)
)

(defun select (selector)
  (print_db (remove-if-not selector *db*))
)

(defun update (selector &key t�tulo autor g�nero a�o pa�s)
  (setf *db*
        (mapcar
         #'(lambda (row)
             (when (funcall selector row)
               (if t�tulo (setf (getf row :t�tulo) t�tulo))
               (if autor (setf (getf row :autor) autor))
               (if g�nero (setf (getf row :g�nero) g�nero))
               (if a�o (setf (getf row :a�o) a�o))
               (if pa�s (setf (getf row :pa�s) pa�s))
              )
             row
             )
         *db*
         )
    )
)

(defun delete-rec (selector)
  (setf *db* (remove-if selector *db*))
   (format t "Registro eliminado. ~%Base de datos actualizada.")
   (values)
)

(defun make-comp-exp (campo valor)
  `(equalp (getf book ,campo) ,valor)
)

(defun make-comp-list (args)
  (loop while args
        collecting (make-comp-exp (pop args) (pop args))
   )
)

(defmacro match (&rest campos)
  `#'(lambda (book)
       (and ,@(make-comp-list campos))
     )
)
