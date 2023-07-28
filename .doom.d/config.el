;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Bart van Nierop"
      user-mail-address "mail@bvnierop.nl")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

(use-package! csharp-tree-sitter
  :hook '(csharp-tree-sitter-mode . rainbow-delimiters-mode)
  :config
  ;; tree-sitter-indent is broken for csharp
  (add-hook! 'csharp-tree-sitter-mode (tree-sitter-indent-mode -1))

  ;; (set-electric! 'csharp-tree-sitter-mode :chars '(?\n ?\}))
  (set-rotate-patterns! 'csharp-tree-sitter-mode
                        :symbols '(("public" "protected" "private")
                                   ("class" "struct" "record")))
  (set-ligatures! 'csharp-tree-sitter-mode
                  ;; Functional
                  :lambda        "() =>"
                  ;; Types
                  :null          "null"
                  :true          "true"
                  :false         "false"
                  :int           "int"
                  :float         "float"
                  :str           "string"
                  :bool          "bool"
                  :list          "List"
                  ;; Flow
                  :not           "!"
                  :in            "in"
                  :and           "&&"
                  :or            "||"
                  :for           "for"
                  :return        "return"
                  :yield         "yield")

  (sp-local-pair 'csharp-tree-sitter-mode "<" ">"
                 :when '(+csharp-sp-point-in-type-p)
                 :post-handlers '(("| " "SPC")))

  ;; Setup LSP
  (when (modulep! :lang csharp +lsp)
    (add-hook! 'csharp-tree-sitter-mode-local-vars-hook #'lsp! 'append)
    (after! eglot
      (add-to-list 'eglot-server-programs `(csharp-tree-sitter-mode "OmniSharp" "-lsp" "-v")))))

;;   (defadvice! +csharp-disable-clear-string-fences-a (fn &rest args)
;;     "This turns off `c-clear-string-fences' for `csharp-mode'. When
;; on for `csharp-mode' font lock breaks after an interpolated string
;; or terminating simple string."
;;     :around #'csharp-disable-clear-string-fences
;;     (unless (eq major-mode 'csharp-tree-sitter-mode)
;;       (apply fn args))))

(use-package! fsharp-mode
  :config
  (use-package! eglot-fsharp
    :config
    (when (modulep! :lang fsharp +lsp)
      (require 'eglot-fsharp)
      (setq eglot-fsharp-server-args '("--adaptive-lsp-server-enabled" "--verbose"))
      (add-hook! 'fsharp--mode-local-vars-hook #'lsp! 'append))))


;; (ensure-package fsharp-mode
;;   :demand t
;;   :config
;;   (use-feature eglot-fsharp
;;     :config
;;     (require 'eglot-fsharp)
;;     (add-hook 'fsharp-mode-hook (lambda ()
;;                                   (interactive)
;;                                   (enable-minor-modes '(company-mode dtrt-indent-mode) :for 'fsharp-mode)
;;                                   (eglot-ensure)))))

(use-package! org
  :config
  (add-hook! org-mode
    (setq fill-column 80)
    (auto-fill-mode t)))

(use-package! org
  :config
  (setq org-startup-indented  t
        org-src-fontify-natively t
        org-startup-folded t))

(use-package! org
  :config
  (setq org-src-tab-acts-natively nil))

(map!
 :mode org-mode
 :prefix "C-c"
 "a" #'org-agenda
 "l" #'org-store-link)

(defun bvn/org-mode-indent-source ()
  (interactive)
  (org-edit-special)
  (evil-indent (point-min) (point-max))
  (org-edit-src-exit))

(map! :localleader
      :mode org-mode
      "=" #'bvn/org-mode-indent-source)

(use-package! org
  :config (require 'org-protocol))

(use-package! org
  :config
  (require 'org-protocol)

  (defvar org-protocol-capture-nest-level 0
    "Tracks capture level depth in org-protocol captures.")

  (add-hook! 'org-capture-mode-hook
             :depth -99
             (cl-incf org-protocol-capture-nest-level))

  (add-hook! 'org-capture-after-finalize-hook
             :depth -99
             (cl-decf org-protocol-capture-nest-level))

  (cl-defmacro bvn/in-org-protocol-capture-frame (&body body)
    (let ((frame-name (cl-gensym "frame-name-")))
      `(let ((,frame-name (substring-no-properties
                           (cdr (assoc 'name (frame-parameters))))))
         (when (string-prefix-p "org-protocol-capture" ,frame-name)
           ,@body))))

  (add-hook! 'doom-switch-window-hook
    (bvn/in-org-protocol-capture-frame
     (when (and (string= "*doom*" (buffer-name (current-buffer)))
                (> (count-windows) 1))
       (delete-window (get-buffer-window "*doom*")))))

  (add-hook! 'doom-switch-buffer-hook
    (bvn/in-org-protocol-capture-frame
     (when (and (string= "*doom*" (buffer-name (current-buffer)))
                (> (count-windows) 1))
       (delete-window (get-buffer-window "*doom*")))))

  (add-hook! 'doom-after-init-hook :append
    (set-popup-rule! "^\\*Capture\\*$\\|CAPTURE-.*$" :ignore t)
    (+popup-cleanup-rules-h))

  (add-hook! 'org-capture-after-finalize-hook
    (interactive)
    (bvn/in-org-protocol-capture-frame
     (when (zerop org-protocol-capture-nest-level)
       (delete-frame)))))

(use-package! org-roam
  ;; :straight (:files (:defaults "extensions/*"))
  :init (setq org-roam-v2-ack t)
  :hook (after-init . org-roam-db-autosync-mode)
  :custom
  (org-roam-directory "~/.org-roam")
  (org-roam-db-location "~/.org-roam/org-roam.db")
  (org-roam-v2-ack t)
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :target (file+head "%<%Y%m%d%H%M%S-%N>.org"
                         "#+title: ${title}\n")
      :unnarrowed t))) ;; Remove the slug from the default file name, to prevent file name changing

  (org-roam-capture-ref-templates
   '(("r" "ref" plain "%?"
      :target (file+head "%<%Y%m%d%H%M%S-%N>.org"
                         "#+title: ${title}")
      :unnarrowed t)))
  :config
  (require 'org-roam-protocol))

;; TODO Map keybindings to leader
(after! org-roam
  (map!
   :map global-map
   :prefix "C-c n"
   "n" #'org-roam-buffer-toggle
   "f"  #'org-roam-node-find
   "g"  #'org-roam-graph
   "d d"  #'org-roam-dailies-goto-today
   "d p"  #'org-roam-dailies-goto-previous-note
   "d n"  #'org-roam-dailies-goto-next-note
   "d y"  #'org-roam-dailies-goto-yesterday)

  (map!
   :map org-mode-map
   :prefix "C-c n"
   "i"  #'org-roam-node-insert
   "I"  #'org-roam-insert-immediate
   "n"  #'org-roam-buffer-toggle
   "n"  #'org-roam-buffer-toggle
   "f"  #'org-roam-node-find
   "g"  #'org-roam-graph
   "d d"  #'org-roam-dailies-goto-today
   "d y"  #'org-roam-dailies-goto-yesterday))
