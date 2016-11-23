(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; install use-package, if not installed
(unless (package-installed-p 'use-package) 
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
  (setq use-package-always-ensure t) ;; auto install any packages not installed

(use-package evil
  :config
  (evil-mode 1))
(use-package helm-config
  :ensure helm
  :init
  (setq helm-M-x-fuzzy-match   t ; optional fuzzy matching for helm-M-x
   helm-buffers-fuzzy-matching t ; optional fuzzy matching for helm-mini
   helm-recentf-fuzzy-match    t)
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-mini)
         ("C-x C-f" . helm-find-files)
         ("C-x r b" . helm-bookmarks)
	 :map helm-map
         ("<tab>" . helm-execute-persistent-action) ; rebind tab to do persistent action
         ("C-i" . helm-execute-persistent-action) ; make TAB work in terminal
         ("C-z" . helm-select-action) ; list actions using C-z
	 )
  :config
  (helm-mode 1))

(setq-default indent-tabs-mode nil) ; SPACE is used instead of TAB
(load-theme 'tango-dark) ;; loads the specified theme
