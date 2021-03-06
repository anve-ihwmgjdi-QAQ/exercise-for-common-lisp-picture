
(defun make-pgm[p2] (path-name p-width p-high arr)
  (with-open-file (p path-name :direction :output)
    (format p "P2 ~A ~A 255" p-width p-high)
    (let ((ar-high (- p-high 1))
	  (ar-width (- p-width 1)))
      (labels ((iter (h w)
		 (cond ((> h ar-high) nil)
		       ((>= w ar-width)
			(progn (print (aref arr h w) p)
			       (iter (+ h 1) 0)))
		       (t (progn (print (aref arr h w) p)
				 (iter h (+ w 1)))))))
	(iter 0 0)))))

(defun make-pgm[p5] (path-name p-width p-high arr)
  (with-open-file (p path-name :direction :output :element-type '(unsigned-byte 8))
    (do ((str (format nil "P5 ~A ~A 255~%" p-width p-high) (subseq str 1)))
	((equal str ""))
      (write-byte (char-code (aref str 0)) p))
    (let ((arr-high (- p-high 1))
	  (arr-width (- p-width 1)))
      (labels ((iter (h w)
		 (cond ((> h arr-high) nil)
		       ((>= w arr-width)
			(progn (write-byte (aref arr h w) p)
			       (iter (+ h 1) 0)))
		       (t (progn (write-byte (aref arr h w) p)
				 (iter h (+ w 1)))))))
	(iter 0 0)))))
