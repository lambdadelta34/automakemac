(fset 'yes-or-no-p 'y-or-n-p)

(setq gc-cons-threshold (* 20 1000 1000))
(setq read-process-output-max (* 1024 1024 3))

(defun my/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'my/display-startup-time)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq native-comp-async-report-warnings-errors nil)

(setq auth-sources '("~/.emacs.d/.authinfo.gpg"))

(straight-use-package 'org)
(straight-use-package 'use-package)
(use-package straight
             :custom (straight-use-package-by-default t))
(setq use-package-always-demand t)

(setq leader "SPC")
(setq alt-leader "M-SPC")

(add-to-list 'default-frame-alist
             '(font . "Hack Nerd Font 12"))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq inhibit-startup-screen t)

;; (toggle-frame-fullscreen)
(add-to-list 'default-frame-alist '(fullscreen . fullboth))
;; (add-hook )
;; (add-to-list 'default-frame-alist '(width . 200))
;; (add-to-list 'default-frame-alist '(height . 55))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(global-display-line-numbers-mode)

(show-paren-mode t)
(setq show-paren-style 'mixed)

(global-auto-revert-mode 1)

(add-hook 'before-save-hook 'd-trailing-whitespace)
(defun d-trailing-whitespace ()
  (unless (derived-mode-p 'markdown-mode)
    (delete-trailing-whitespace)))

(setq vc-make-backup-files t ;; emacs doesn't do backup for VCed files
      version-control t      ;; Use version numbers for backups.
      kept-new-versions 10   ;; Number of newest versions to keep.
      kept-old-versions 0    ;; Number of oldest versions to keep.
      delete-old-versions t  ;; Don't ask to delete excess backup versions.
      backup-by-copying t    ;; Copy all files, don't rename them.
      backup-directory-alist '(("" . "~/.emacs.d/backup/per-save")))

(defun force-backup-of-buffer ()
    ;; Make a special "per session" backup at the first save of each
    ;; emacs session.
    (when (not buffer-backed-up)
      ;; Override the default parameters for per-session backups.
      (let ((backup-directory-alist '(("" . "~/.emacs.d/backup/per-session")))
            (kept-new-versions 3))
        (backup-buffer)))
    ;; Make a "per save" backup on each save.  The first save results in
    ;; both a per-session and a per-save backup, to keep the numbering
    ;; of per-save backups consistent.
    (let ((buffer-backed-up nil))
      (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer)

(setq auto-save-default nil)

(setq visible-bell nil)
(setq ring-bell-function 'ignore)

(setq initial-major-mode 'org-mode)

(use-package emacs
  :custom
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs t)
  ;; (modus-themes-tabs-accented t)
  (modus-themes-paren-match '(bold intense))
  (modus-themes-prompts '(bold intense))
  (modus-themes-org-blocks 'tinted-background)
  (modus-themes-region '(bg-only accented))
  (modus-themes-mode-line '(accented borderless))
  (modus-themes-hl-line '(underline accented intense))
  (modus-themes-completions '((matches . (extrabold background intense))
                              (selection . (semibold accented intense))
                              (popup . (accented intense)))
                              )
  (modus-themes-headings
    '(
     (1 . (rainbow overline background variable-pitch 1.4))
     (2 . (rainbow background 1.3))
     (3 . (rainbow bold 1.2))
     (t . (semilight 1.1))
    ))
  (modus-themes-scale-headings t)
  (modus-themes-variable-pitch-ui t)
  (modus-themes-subtle-line-numbers t)
  :config
  (load-theme 'modus-operandi)
)

(org-babel-load-file "~/.emacs.d/packages.org")

(org-babel-load-file "~/.emacs.d/keymaps.org")

;; (use-package nyan-mode
  ;; (setq nyan-wavy-trail t
  ;;       nyan-animate-nyancat t)
  ;; :config
  ;; (nyan-mode))
