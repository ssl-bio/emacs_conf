;; Turn off mouse interface early in startup to avoid momentary display
(when window-system
  ;;   (menu-bar-mode -1) ;;disables menu bar
  (tool-bar-mode -1) ;;disables toolbar
  ;;   (scroll-bar-mode -1) ;;disables scroll bar
  (tooltip-mode -1) ;;disables help in a pop-up window
  )

(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; Disable package.el in favor of straight.el
(setq package-enable-at-startup nil)

;; bootstrap straight.el
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

;; Use straight.el for use-package expressions
(straight-use-package 'use-package)

;; Load org
(use-package org
  :straight (org :type git
		 :repo "https://git.savannah.gnu.org/git/emacs/org-mode.git"
		 :local-repo "org"
		 :depth full
		 :pre-build (straight-recipes-org-elpa--build)
		 :build (:not autoloads)
		 :files (:defaults "lisp/*.el" ("etc/styles/" "etc/styles/*")))
  :hook ((org-mode . org-indent-mode))
  :config
  ;; (setq org-ellipsis "▿ ")
  ;; (setq org-hide-emphasis-markers t)
  (setq org-use-speed-commands t)
  (setq org-image-actual-width 550)
  (setq org-highlight-latex-and-related '(latex script entities))
  ;; reduce space between header and tags
  (setq org-tags-column 47)

  ;;Function to indent code
  (defun indent-org-block ()
    (interactive)
    (when (org-in-src-block-p)
      (org-edit-special)
      (indent-region (point-min) (point-max))
      (org-edit-src-exit)))

  ;; Keybinding
  (define-key org-mode-map
    (kbd "C-x /") #'indent-org-block)
 )
;; (straight-use-package 'org)

;;; Load the config
(require 'org)
(setq config-file (concat user-emacs-directory "config.org"))
(defalias 'org-file-name-concat #'file-name-concat)
(org-babel-load-file config-file)

