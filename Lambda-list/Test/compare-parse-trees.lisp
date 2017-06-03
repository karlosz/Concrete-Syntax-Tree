(cl:in-package #:concrete-syntax-tree-lambda-list-test)

(defgeneric compare-parse-trees (tree1 tree2))

(defmethod compare-parse-trees (tree1 tree2)
  (declare (ignore tree1 tree2))
  nil)

(defun compare-lists (list1 list2)
  (and (= (length list1) (length list2))
       (every #'compare-parse-trees list1 list2)))

(defmethod compare-parse-trees
    ((tree1 cst::lambda-list-type) (tree2 cst::lambda-list-type))
  (and (eq (class-of tree1) (class-of tree2))
       (compare-lists (cst::children tree1) (cst::children tree2))))

(defmethod compare-parse-trees
    ((tree1 cst::implicit-parameter-group)
     (tree2 cst::implicit-parameter-group))
  (and (eq (class-of tree1) (class-of tree2))
       (compare-lists (cst::parameters tree1) (cst::parameters tree2))))

(defmethod compare-parse-trees
    ((tree1 cst::explicit-parameter-group)
     (tree2 cst::explicit-parameter-group))
  (and (eq (class-of tree1) (class-of tree2))
       (eq (cst::name (cst::keyword tree1)) (cst::name (cst::keyword tree2)))
       (compare-lists (cst::parameters tree1) (cst::parameters tree2))))

(defmethod compare-parse-trees
    ((tree1 cst::singleton-parameter-group)
     (tree2 cst::singleton-parameter-group))
  (and (eq (class-of tree1) (class-of tree2))
       (eq (cst::name (cst::keyword tree1)) (cst::name (cst::keyword tree2)))
       (eq (cst::name (cst::parameter tree1)) (cst::name (cst::parameter tree2)))))

(defmethod compare-parse-trees
    ((tree1 cst::simple-variable)
     (tree2 cst::simple-variable))
  (eq (cst::name tree1) (cst::name tree2)))

(defmethod compare-parse-trees
    ((tree1 cst::ordinary-optional-parameter)
     (tree2 cst::ordinary-optional-parameter))
  (and (eq (cst::name tree1) (cst::name tree2))
       (equal (cst::form tree1) (cst::form tree2))
       (or (and (null (symbol-package (cst::supplied-p tree1)))
                (null (symbol-package (cst::supplied-p tree2))))
           (eq (cst::supplied-p tree1) (cst::supplied-p tree2)))))

(defmethod compare-parse-trees
    ((tree1 cst::generic-function-optional-parameter)
     (tree2 cst::generic-function-optional-parameter))
  (eq (cst::name tree1) (cst::name tree2)))

(defmethod compare-parse-trees
    ((tree1 cst::ordinary-key-parameter)
     (tree2 cst::ordinary-key-parameter))
  (and (eq (cst::name tree1) (cst::name tree2))
       (eq (cst::keyword tree1) (cst::keyword tree2))
       (equal (cst::form tree1) (cst::form tree2))
       (or (and (null (symbol-package (cst::supplied-p tree1)))
                (null (symbol-package (cst::supplied-p tree2))))
           (eq (cst::supplied-p tree1) (cst::supplied-p tree2)))))

(defmethod compare-parse-trees
    ((tree1 cst::generic-function-key-parameter)
     (tree2 cst::generic-function-key-parameter))
  (and (eq (cst::name tree1) (cst::name tree2))
       (eq (cst::keyword tree1) (cst::keyword tree2))))
