;;; Begin initialization
;; This file was downloaded from https://github.com/danielmai/.emacs.d/blob/master/init.el
;; Turn off mouse interface early in startup to avoid momentary display
(when window-system
  ;;   (menu-bar-mode -1) ;;disables menu bar
  (tool-bar-mode -1) ;;disables toolbar
  ;;   (scroll-bar-mode -1) ;;disables scroll bar
  (tooltip-mode -1) ;;disables help in a pop-up window
  )

(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ;; ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-verbose t)

;;; Load the config
(org-babel-load-file (concat user-emacs-directory "config.org"))

