;; Bootstrap straight.el
;;
;; I _really_ don't want to do this here, but...
;; I have to load org throught straight.el before anything else
;; loads it. And since I use a literate config... I load it first thing.
;;
;; So we do it here instead.
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'org)

(let ((org-mode-config-file (or (getenv "EMACS_CONFIG_ORG_FILE") "config.org")))
  (org-babel-load-file (expand-file-name org-mode-config-file user-emacs-directory)))
