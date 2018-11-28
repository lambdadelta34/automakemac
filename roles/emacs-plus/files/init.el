;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; add packages repo
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; you should add every theme folder
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/dracula")
(load-theme 'dracula t)
(tool-bar-mode -1)
