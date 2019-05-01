;;; i want this to be loaded first. running this from config.org is tedious.
(fset 'yes-or-no-p 'y-or-n-p)
(org-babel-load-file "~/.emacs.d/config.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit powerline which-key use-package tuareg smartparens rjsx-mode reason-mode projectile neotree haskell-mode ggtags general flycheck flx evil-surround evil-nerd-commenter evil-args dumb-jump dracula-theme counsel company-quickhelp all-the-icons ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(awesome-tab-selected ((t :background "#bd93f9")))
 '(awesome-tab-unselected ((t :background "#8BE9FD")))
 '(sp-show-pair-match-content-face ((t :foreground "#00ffff" :background "#6700D4")) t)
 '(sp-show-pair-match-face ((t :foreground "#00ffff" :background "#6700D4"))))
