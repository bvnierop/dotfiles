(let ((org-mode-config-file (or (getenv "EMACS_CONFIG_ORG_FILE") "config.org")))
  (org-babel-load-file (expand-file-name org-mode-config-file user-emacs-directory)))
