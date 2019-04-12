;; set theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/dracula")
;; (load-theme 'dracula t)
(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))
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
;; ivy
(use-package ivy
  :ensure t
  :defer t
  :diminish (ivy-mode . "")
  :init
  (ivy-mode 1)
  (setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
        (t      . ivy--regex-fuzzy)))
  :general
  (:keymaps 'ivy-minibuffer-map
    "C-j" '(ivy-next-line :which-key "next line")
    "C-k" '(ivy-previous-line :which-key "prev line")
    "C-h" '(ivy-beginning-of-buffer :which-key "beginning of ivy minibuffer")
    "C-l" '(ivy-end-of-buffer :which-key "end if ivy mini buffer")
    "RET" '(ivy-immediate-done :which-key "exits fro mivy search without selecting curent item")
    "C-v" '(ivy-scroll-up-command :which-key "page up ivy buffer")
    "M-v" '(ivy-scroll-down-command :which-key "page down ivy buffer"))
  (:states 'normal
    :prefix "SPC"
    "bs" 'ivy-switch-buffer
    "bn" 'next-buffer
    "bd" 'kill-this-buffer
    "bp" 'previous-buffer)

  :config
  (setq ivy-use-virtual-buffers t
    ivy-height 20
    ivy-count-format "(%d/%d) "))

;; counsel
(use-package counsel
  :defer t
  :ensure t
  :general
  ("M-x" 'counsel-M-x)
  (:states 'normal
    :prefix "SPC"
    "/" 'counsel-fzf))

;; ag
(use-package ag
  :defer t
  :ensure t
  :config
  (setq ag-highlight-search t))

;; swiper
(use-package swiper
  :defer t
  :ensure t
  :general
  (:states 'normal
    "C-s" 'swiper
    "/" 'swiper))

;; flx/fuzzy
(use-package flx
  :defer t
  :ensure t)

;; key menu
(use-package which-key
  :defer t
  :ensure t
  :init
  (which-key-mode)
  :config
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-side-window-max-height 0.33
        which-key-idle-delay 0.5))

;;required for evil
(use-package undo-tree
  :defer t
  :ensure t
  :config
  (global-undo-tree-mode))
(use-package goto-chg
  :ensure t)

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
(use-package projectile
  :defer 2
  :ensure t
  :preface
  (defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))
  :init
  (projectile-mode +1)
  (setq projectile-completion-system 'ivy
        projectile-require-project-root nil
        projectile-enable-caching t)
  :general
  (:states 'normal
    :keymaps 'projectile-mode-map
    :prefix "SPC"
    "p" 'projectile-command-map
    "pt" 'neotree-project-dir
    "ff" 'projectile-find-file))

;; goto definition
(use-package dumb-jump
  :defer 3
  :ensure t
  :config
  (setq dumb-jump-force-searcher 'ag
        dumb-jump-aggressive nil
	dumb-jump-selector 'ivy)
  :general
  (:states '(normal insert)
    :prefix "SPC"
    :non-normal-prefix "M-SPC"
    "jd" 'dumb-jump-go
    "jb" 'dumb-jump-back
    "jq" 'dumb-jump-quick-look))

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

(use-package haskell-mode
  :defer t
  :ensure t)
(use-package reason-mode
  :defer t
  :ensure t
  :init
  (add-hook 'reason-mode-hook (lambda ()
            (add-hook 'before-save-hook #'refmt-before-save))))
(use-package tuareg
  :defer t
  :ensure t)
(use-package js2-mode
  :defer t
  :ensure t
  :mode "\\.js\\'"
  :config
  (setq-default js2-strict-trailing-comma-warning nil))
(use-package rjsx-mode
  :defer t
  :ensure t)

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
