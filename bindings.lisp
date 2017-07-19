(cl:in-package #:concrete-syntax-tree)

;;;; This code provides useful operations on bindings as used by LET
;;;; and LET*.  The bindings are in the form of a CST.  Recall that
;;;; such a binding can have three different shapes, namely VAR,
;;;; (VAR), or (VAR INIT-FORM).  The last of these three shapes is
;;;; considered canonical.

;;; Check whether a binding is valid, i.e., has one of the three valid
;;; shapes.
(defun valid-binding-p (binding-cst)
  (let ((raw (raw binding-cst)))
    (or (symbolp raw)
        (and (cl:consp raw)
             (or (cl:null (cdr raw))
                 (and (cl:consp (cdr raw))
                      (cl:null (cddr raw))))))))

;;; Check whether each binding in a list of bindings represented as a
;;; CST is valid.
(defun valid-bindings-p (bindings-cst)
  (and (proper-list-p bindings-cst)
       (loop for rest = bindings-cst then (rest rest)
             until (null rest)
             always (valid-binding-p (first rest)))))

;;; Check whether a single binding in the form of a CST represents a
;;; canonical binding.  It is assumed that the binding is valid as
;;; checked by VALID-BINDING-P.
(defun canonical-binding-p (binding-cst)
  (= (length (raw binding-cst)) 2))
