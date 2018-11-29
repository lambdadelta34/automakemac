;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(require 'package)
(eval-when-compile
  (add-to-list 'load-path "~/.emacs.d/elpa")
  (require 'use-package))
;; add packages repo
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/dracula")
(load-theme 'dracula t)
(tool-bar-mode -1)
;; packages
;;required for evil
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))
(use-package goto-chg
  :ensure t)
;; evil mode stuff
(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "gcc" 'evilnc-comment-or-uncomment-lines))
(use-package evil
  :ensure t
  :config
  (evil-mode 1))
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))
(use-package evil-args
  :ensure t
  :bind (:map evil-inner-text-objects-map
         ("a" . evil-inner-arg)
         :map evil-outer-text-objects-map
         ("a" . evil-outer-arg)))
(use-package evil-nerd-commenter
  :ensure t
  :bind (("M-;" . evilnc-comment-or-uncomment-lines)
         ("C-c l" . evilnc-quick-comment-or-uncomment-to-the-line)
         ("C-c c" . evilnc-copy-and-comment-lines)
         ("C-c p" . evilnc-comment-or-uncomment-paragraphs)))
;; icons
(use-package all-the-icons
 :ensure t)
;; neotree
(use-package neotree
  :ensure t
  :init 
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
              (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
              (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
              (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
              (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  :bind ([f8] . neotree-toggle))
