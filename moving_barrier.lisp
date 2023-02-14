(ql:quickload "cl-ppcre")
(ql:quickload "alexandria")

(defun read-file (infile)
  (with-open-file (instream infile :direction :input :if-does-not-exist nil)
    (when instream 
      (let ((string (make-string (file-length instream))))
        (read-sequence string instream)
        string))))

(defun write-file (string outfile &key (action-if-exists :error))
  (check-type action-if-exists (member nil :error :new-version :rename :rename-and-delete 
					   :overwrite :append :supersede))
  (with-open-file (outstream outfile
			     :direction
			     :output
			     :if-does-not-exist :create
			     :if-exists action-if-exists)
    (write-sequence string outstream)))

(defun range (min max &optional (step 1))
  (when (<= min max)
    (cons min (range (+ min step) max step))))

(setf g (quote ((0 0 1 1 2 3 4 5 1 0 0) (0 0 1 1 2 3 4 5 1 0 0) (0 0 1 1 2 3 4 5 1 0 0) (0 0 1 1 2 3 4 5 1 0 0) (3 1 1 1 2 3 4 5 1 1 4) (3 1 1 1 2 3 4 5 1 1 4) (3 1 1 1 2 3 4 5 1 1 4) (0 0 1 1 2 3 4 5 1 0 0) (0 0 1 1 2 3 4 5 1 0 0) (0 0 1 1 2 3 4 5 1 0 0) (0 0 1 1 2 3 4 5 1 0 0))))
  
(defun show-board (output board)
  (loop for i below (car (array-dimensions board)) do
    (loop for j below (cadr (array-dimensions board)) do
      (let ((cell (aref board i j)))
	(format output "~a " cell)))
    (format output "~%")))
  
(defun list-to-2d-array (list)
  (make-array (list (length list)
		    (length (first list)))
	      :initial-contents list))

(defun 2d-array-to-list (array)
  (loop for i below (array-dimension array 0)
        collect (loop for j below (array-dimension array 1)
                      collect (aref array i j))))

(defun range (max &key (min 0) (step 1))
   (loop for n from min below max by step
      collect n))

(setf garray (list-to-2d-array g))

(defun change_columns (garray column_list value)
  (mapcar #'(lambda (j)
	      (mapcar
	       #'(lambda (i) (setf (aref garray i j) value))
	       (range (cadr (array-dimensions garray)))
	       ))
	  column_list))

(defun return_array (garray i)
  (let ((garray2 (alexandria:copy-array garray)))
    (change_columns garray2 (remove i (range 8 :min 3)) 1)
    (change_columns garray2 (list i) 2 )
    garray2
    ))

(defun get_grid_array (i)
  (with-output-to-string (str)
    (show-board str
	      (return_array garray i)
	      )
  str))


(get_grid_array 3)


(defun get_grid_array (i)
(with-output-to-string (str)
  (show-board str
	      (return_array garray i)
	      )
  str))

(defun replace_grd_string (string pos)
  (cl-ppcre:regex-replace-all
   "structure_variable"
   string
   (get_grid_array pos)
   )
  )

(defun write_grd (infile outfile pos)
  (write-file
   (replace_grd_string (read-file infile) pos)
   outfile :action-if-exists :overwrite)
  )


(mapcar #'(lambda (i) 
	    (write_grd "moving_barrier.grd"
		       (concatenate 'string "m" (write-to-string i) ".grd")
		       i))
	(range 9 :min 2 ))

(range 7 :min 2 )

(defun sif_variable_list (max min)
  (setf mesh_files (mapcar #'(lambda (i) (concatenate 'string
						      "m"
						      (write-to-string i)))
			 (concatenate 'list
				      (range 9 :min 2 )
				      (reverse (range 8 :min 3 )))
			 ))
  (defun fpor1 (i)  (+ 5 (* i i 0.05)) )
  
  (setf porosity_values
	(mapcar #'(lambda (i) (mapcar #'(lambda (j) (list (fpor1
							   i) j)) mesh_files))  (range 20 :min 00 )))

  (setf (cdr (last mesh_files)) mesh_files)

  (mapcar #'(lambda (i j) (list
			   (concatenate 'string
					"mb"
					(format nil "~4,'0D" i)
					".vtu"
					)
			   (fpor1 i)
			   j
			   ))
	  (range max :min min) mesh_files)
  )



;mesh_files

(defun process_string (string &key (grd_directory "m1") (fname "moving_barrier.vtu") (porosity "1.0e4 1.0e4"))
  (setf string1
	(cl-ppcre:regex-replace-all
	 "post_file_variable"
	 string
	 fname))
  (setf string2
	(cl-ppcre:regex-replace-all
	 "porosity_variable"
	 string1
	 porosity))
  (setf string3
	(cl-ppcre:regex-replace-all
	 "grd_directory"
	 string2
	 grd_directory))
  string3
  )

(mapcar #'(lambda (i) (process_string
		       (read-file "moving_barrier.sif")
		       :fname (format nil "~a" (car i))
		       :porosity (format nil "~f ~f" (cadr i) (cadr i))
		       :grd_directory (format nil "~a" (caddr i))
		       ))
	(sif_variable_list 10 0)
	)

(defun write_new_sif (infile outfile
		      &key (fname  "f10.sif")
			(porosity "0.5e04 0.5e04")
			)
  (setf readstring (process_string
		    (read-file infile)
		    :fname fname
		    :porosity porosity
		    ))
  (write-file readstring  outfile :action-if-exists :overwrite)
  )


(defun write-sif-files-to-folder (fname infile sif-folder values fpor)
  (loop for i in values
	 do (let ((fname
		    (concatenate 'string
				 fname
				 "_t"
				 (format nil "~5,'0D" i)
				 ".vtu"
				 ))
		  (outfile
		    (concatenate 'string
				 sif-folder
				 fname
				 (format nil "~5,'0D" i)
				 ".sif"
				 ))
		  (porosity
		    (concatenate 'string
				 (let ((npor (fpor i)))
				   (format nil "~5,2F ~5,2F" npor npor)
				   )))
		  )
	      (write_new_sif
	       infile
	       outfile
	       :fname fname
	       :porosity porosity )
	      ))
)

(setf infile (concatenate 'string *ROOT* "moving_barrier.sif"))

(setf SIF-FOLDER (concatenate 'string *ROOT* "/sif/"))

(defmacro fpor1 (i)
  `(+ 10 (* ,i ,i 0.5))
  )

(defmacro fpor2 (i)
  `(+ 10 (* ,i 5))
  )

(write-sif-files-to-folder "moving_barrier"
			   infile
			   SIF-FOLDER
			   (range 200 300)
			   'fpor1)



(mapcar #'(lambda (i)
	    (list (fpor1 i) (fpor2 i)))
	    (range 0 200))
