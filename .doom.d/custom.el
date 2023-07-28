(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((projectile-project-test-suffix . "Tests.fs")
     (projectile-project-test-suffix . "Tests")
     (eval add-hook 'after-save-hook
           (lambda nil
             (set-process-sentinel
              (start-process-shell-command "sync-roam-notes" "*roam-notes-auto-sync*"
                                           (format "git add --all && git commit --allow-empty -m \"auto commit: %s@%s on %s\" && git pull --rebase && git push origin main"
                                                   (user-login-name)
                                                   (system-name)
                                                   (current-time-string)))
              (lambda
                (proc change)
                (if
                    (zerop
                     (process-exit-status proc))
                    (message "Org roam synchronized")
                  (when
                      (y-or-n-p "Org roam sync failed. Do you want to solve using magit?")
                    (magit-status))))))
           100 t)
     (eval setq-local org-roam-db-location
           (expand-file-name "org-roam.db" org-roam-directory))
     (eval setq-local org-roam-directory
           (concat
            (expand-file-name
             (locate-dominating-file default-directory ".dir-locals.el"))
            "roam/"))
     (eval add-hook 'after-save-hook
           (lambda nil
             (set-process-sentinel
              (start-process-shell-command "sync-roam-notes" "*roam-notes-auto-sync*"
                                           (format "git add --all && git commit --allow-empty -m \"auto commit: %s@%s on %s\" && git pull --rebase && git push origin master"
                                                   (user-login-name)
                                                   (system-name)
                                                   (current-time-string)))
              (lambda
                (proc change)
                (if
                    (zerop
                     (process-exit-status proc))
                    (message "Org roam synchronized")
                  (when
                      (y-or-n-p "Org roam sync failed. Do you want to solve using magit?")
                    (magit-status))))))
           100 t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
