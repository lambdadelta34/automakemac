;; set theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/dracula")
;; (load-theme 'dracula t)
;; (use-package doom-themes
;;   :ensure t
;;   :init
;;   (setq doom-neotree-file-icons t
;; 	doom-dracula-brighter-comments t
;; 	doom-dracula-brighter-modeline t)
;;   (load-theme 'doom-dracula t)
;;   :config
;;   (doom-themes-neotree-config))
  ;; (set-face-background 'region "red"))
  ; (doom-themes-set-faces 'doom-dracula
  ;   (region :foreground "red")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages
;; mac $PATH finding
;; (use-package exec-path-from-shell
;;   :if (memq window-system '(mac ns))
;;   :ensure t
;;   :init
;;   (exec-path-from-shell-initialize))

;; icons
(use-package all-the-icons
  :defer t
  :ensure t)

;; neotree
(use-package neotree
  :defer t
  :ensure t
  :preface
  (defun neotree-close-parent ()
    "Close parent directory of current node."
    (interactive)
    (neotree-select-up-node)
    (let* ((btn-full-path (neo-buffer--get-filename-current-line))
           (path (if btn-full-path btn-full-path neo-buffer--start-node)))
          (when (file-name-directory path)
            (if (neo-buffer--expanded-node-p path) (neotree-enter)))))
  :init
  (setq neo-theme 'icons)
  (add-hook 'neo-after-create-hook
            (lambda (&rest _) (display-line-numbers-mode -1)))
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "x") 'neotree-close-parent)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "I") 'neotree-hidden-file-toggle)
              (define-key evil-normal-state-local-map (kbd "z") 'neotree-stretch-toggle)
              (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
              (define-key evil-normal-state-local-map (kbd "m") 'neotree-rename-node)
              (define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
              (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)
              (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
              (define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-horizontal-split)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
  :general
  (:states 'normal
           "TAB" 'neotree-toggle))

;; projectile
;; goto definition
; (use-package dumb-jump
;   :defer 3
;   :ensure t
;   :config
;   (setq dumb-jump-force-searcher 'ag
;         dumb-jump-aggressive nil
; 	dumb-jump-selector 'ivy)
;   :general
;   (:states '(normal insert)
;     :prefix "SPC"
;     :non-normal-prefix "M-SPC"
;     "jd" 'dumb-jump-go
;     "jb" 'dumb-jump-back
;     "jq" 'dumb-jump-quick-look))

;; lsp
; (use-package lsp-haskell
;   :ensure t)
; (use-package lsp-ruby
;   :ensure t)
; (use-package lsp-mode
;   :ensure t
;   :init
;   (add-hook 'prog-mode-hook 'lsp-mode)
;   :config
;   (add-hook 'haskell-mode-hook #'lsp-haskell-enable)
; 	(setq lsp-haskell-process-path-hie "hie-wrapper")
;   (add-hook 'ruby-mode-hook #'lsp-ruby-enable))

; (use-package lsp-ui
;   :ensure t
;   :config
;   (setq lsp-ui-sideline-ignore-duplicate t)
;   (add-hook 'lsp-mode-hook 'lsp-ui-mode)
;   (add-hook 'haskell-mode-hook 'flycheck-mode)
;   (add-hook 'haskell-mode-hook 'flycheck-mode)
;   (add-hook 'ruby-mode-hook 'flycheck-mode))
;; (use-package eglot
;;   :ensure t
;;   :config
;;   (add-to-list 'eglot-server-programs '(ruby-mode . ("solargraph" "stdio")))
;;   ; (add-to-list 'eglot-server-programs '(caml-mode . ("ocaml-language-server" "--stdio")))
;;   ; (add-to-list 'eglot-server-programs '(js-mode . ("javascript-typescript-stdio")))
;;   ; (add-to-list 'eglot-server-programs '(rjsx-mode . ("javascript-typescript-stdio")))
;;   ; (add-to-list 'eglot-server-programs '(reason-mode . ("ocaml-language-server" "--stdio")))
;;   ; (add-to-list 'eglot-server-programs '(haskell-mode . ("hie-wrapper"))))

;;   ; (add-hook 'ruby-mode-hook 'eglot-ensure)
;;   (add-hook 'caml-mode-hook 'eglot-ensure)
;;   (add-hook 'js-mode-hook 'eglot-ensure)
;;   (add-hook 'rjsx-mode 'eglot-ensure)
;;   (add-hook 'reason-mode-hook 'eglot-ensure)
;;   (add-hook 'haskell-mode-hook 'eglot-ensure))


;;;;;;;;;;;
;; syntax checking
(use-package flycheck
  :defer t
  :ensure t
  :preface
  (defun eslint-from-node-modules ()
    "function to find eslint in project folder, not globally"
    (let ((root (locate-dominating-file
                 (or (buffer-file-name) default-directory)
                 (lambda (dir)
                   (let ((eslint (expand-file-name "node_modules/.bin/eslint" dir)))
                     (and eslint (file-executable-p eslint)))))))
      (when root
        (let ((eslint (expand-file-name "node_modules/.bin/eslint" root)))
          (setq-local flycheck-javascript-eslint-executable eslint)))))
  :init
  (global-flycheck-mode)
  :config
  (add-hook 'flycheck-mode-hook #'eslint-from-node-modules))

;; autocomplete
(use-package company
  :defer t
  :ensure t
  :init
  (global-company-mode)
  (setq company-idle-delay 0.2
        company-show-numbers t
        company-tooltip-align-annotations t
        company-selection-wrap-around t)
  :general
  (:keymaps 'company-active-map
    "C-j" 'company-select-next
    "C-k" 'company-select-previous))

(use-package company-quickhelp
  :defer t
  :ensure t
  :init
  (company-quickhelp-mode))

;; smart parens
(use-package smartparens
  :defer t
  :ensure t
  :init
  (smartparens-global-mode 1)
  (sp-pair "'" "'" :actions '(wrap)))
;;; init.el ends here
