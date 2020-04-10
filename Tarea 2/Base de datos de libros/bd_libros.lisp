(defvar *db* nil)

(defun add_book (title author genre year country)
  (list :título title :autor author :género genre :año year :país country)
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
   (read_line "Título")
   (read_line "Autor")
   (read_line "Género")
   (or (parse-integer (read_line "Año") :junk-allowed t) "Desconocido")
   (read_line "País")
  )
)

(defun fill_db ()
  (loop (add_rec (read_rec))
        (unless (y-or-n-p "¿Agregar otro libro?")
          (when (y-or-n-p "¿Mostrar base de datos?")
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
   (format t "Base de datos guardada con éxito.")
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

(defun update (selector &key título autor género año país)
  (setf *db*
        (mapcar
         #'(lambda (row)
             (when (funcall selector row)
               (if título (setf (getf row :título) título))
               (if autor (setf (getf row :autor) autor))
               (if género (setf (getf row :género) género))
               (if año (setf (getf row :año) año))
               (if país (setf (getf row :país) país))
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
