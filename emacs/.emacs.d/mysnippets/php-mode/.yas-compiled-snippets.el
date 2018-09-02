;;; Compiled snippets and support files for `php-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'php-mode
		     '(("dump" "echo \"<pre>\";\necho \"<br>\";\necho \"<br>\";\necho \"<br>\";\nvar_dump($$1);\necho \"</pre>\";" "dump" nil nil nil "/home/oishouya/.emacs.d/mysnippets/php-mode/dump" nil nil)
		       ("debug" "error_log(print_r($1, true), 0);\n" "debug" nil nil nil "/home/oishouya/.emacs.d/mysnippets/php-mode/debug" nil nil)
		       ("object_method" "get_class_methods(\"$1\");" "Object Method" nil nil nil "/home/oishouya/.emacs.d/mysnippets/php-mode/Object Method" nil nil)))


;;; Do not edit! File generated at Wed Aug 22 22:07:24 2018
