(package-initialize)
(require 'package)
; (eval-when-compile
;   (add-to-list 'load-path "~/.emacs.d/elpa")
;   (require 'use-package))

; lazy load packages
(setq package-enable-at-startup nil)
;; add packages repo
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; init use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
;; global config
;; disable startup menu
(setq inhibit-startup-screen t)
;; frame size
(add-to-list 'default-frame-alist '(width . 200))
(add-to-list 'default-frame-alist '(height . 55))
;; force use of spaces
(setq-default indent-tabs-mode nil)
;; enable line numbers
(global-display-line-numbers-mode)
;; same as syntax on in Vim
(turn-on-font-lock)
;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)
;; enable clipboard copy/paste
(setq select-enable-clipboard t)
;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)
;; tab widht
;; (setq-default tab-width 2)
;; autorefresh buffers
(global-auto-revert-mode 1)
;; Highlight tabulations
(setq-default highlight-tabs t)
;; Show trailing white spaces
(setq-default show-trailing-whitespace t)
;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; stop creating backup~ files
(setq make-backup-files nil)
;; stop creating #autosave# files
(setq auto-save-default nil)
;; silent bell
(setq ring-bell-function 'ignore )

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
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages
;; general
(use-package general
  :ensure t
  :config
  (general-evil-setup t)
  (general-define-key
   :states '(normal insert emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   "wd" 'delete-window
   "wc" 'delete-other-windows
   "fed" (lambda () (interactive) (find-file user-init-file))
   "feR" 'eval-buffer
   "fs" 'save-buffer
   "qq" 'save-buffers-kill-terminal))

;; ivy
(use-package ivy
  :ensure t
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
  :ensure t
  :general
  ("M-x" 'counsel-M-x)
  (:states 'normal
    :prefix "SPC"
    "/" 'counsel-fzf))

;; swiper
(use-package swiper
  :ensure t
  :general
  (:states 'normal
    "C-s" 'swiper
    "/" 'swiper))

;; flx/fuzzy
(use-package flx
  :ensure t)

;; key menu
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-side-window-max-height 0.33
        which-key-idle-delay 0.5))

;;required for evil
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))
(use-package goto-chg
  :ensure t)

;; evil mode stuff
(use-package evil
  :ensure t
  :preface
  (defun copy-to-clipboard ()
      (interactive)
      (if (display-graphic-p)
          (progn
            (call-interactively 'clipboard-kill-ring-save)
            )
        (if (region-active-p)
            (progn
              (shell-command-on-region (region-beginning) (region-end) "pbcopy")
              (deactivate-mark)))))

  :init
  (setq evil-motion-state-modes nil)
  :general
  (:states 'normal
    "C-k" 'evil-window-up
    "C-j" 'evil-window-down
    "C-h" 'evil-window-left
    "C-l" 'evil-window-right)
 (:states 'visual
    "y" 'copy-to-clipboard)
  (:states 'normal
    :prefix "SPC"
    "wn" 'evil-window-split
    "w/" 'evil-window-vsplit)
  :config
  (evil-mode 1)
  (add-hook 'ruby-mode-hook
            (function (lambda ()
                        (setq evil-shift-width 2))))
  (unless (display-graphic-p)
      (add-hook 'evil-insert-state-entry-hook (lambda () (send-string-to-terminal "\033[5 q"))) ;; set cursor to bar
      (add-hook 'evil-normal-state-entry-hook (lambda () (send-string-to-terminal "\033[0 q"))))) ;; set cursor to block

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))
(use-package evil-args
  :ensure t
  :general
  (:keymaps 'evil-inner-text-objects-map
    "a" 'evil-inner-arg)
  (:keymaps 'evil-outer-text-objects-map
    "a" 'evil-outer-arg))
(use-package evil-nerd-commenter
  :ensure t
  :general
  (:states 'normal
    "gcc" 'evilnc-comment-or-uncomment-lines)
  (:states 'visual
    "gc" 'evilnc-comment-or-uncomment-lines))

;; icons
(use-package all-the-icons
  :ensure t)

;; neotree
(use-package neotree
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
  :ensure t)
(use-package reason-mode
  :ensure t
  :init
  (add-hook 'reason-mode-hook (lambda ()
            (add-hook 'before-save-hook #'refmt-before-save))))

;;;;;;;;;;;
;; syntax checking
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

;; autocomplete
(use-package company
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
  :ensure t
  :init
  (company-quickhelp-mode))

;; smart parens
(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode 1)
  (sp-pair "'" "'" :actions '(wrap)))
;;; init.el ends here
