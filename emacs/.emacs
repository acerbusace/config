;;------------------------------------------------------------------------------
;; Packages
;;------------------------------------------------------------------------------
(require 'package)
(setq package-enable-at-startup nil)
;; add mepla to the package-archives list
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/")) ; stable melpa package repository
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/")) ; bleeding-edge melpa package repository
(package-initialize)


;; use-package
;;-------------
(unless (package-installed-p 'use-package) ; installs use-package
  (package-refresh-contents)
  (package-install 'use-package))

;; loads use-package
(eval-when-compile
  (require 'use-package)
  (require 'diminish)                ;; if you use :diminish
  (require 'bind-key))                ;; if you use any :bind variant

;; install required packages
;;---------------------------
(use-package evil ; evil - adds vim-like functionality (vim-mode)
  :ensure t ;; auto install package
  :pin melpa ;; dependence (goto-chr) does not exists in melpa stable, so use melpa repository instead
  :config
  (evil-mode 1))

(use-package ivy
  :ensure t
  :pin melpa-stable
  :init
  (ivy-mode 1)
  :bind
  ;; ivy-based interface to standard commands
  (("C-s" . swiper)
   ;; ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-h f" . counsel-describe-function)
   ("C-h v" . counsel-describe-variable)
   ;; ("<f1> l" . counsel-load-library)
   ("C-h S" . counsel-info-lookup-symbol)
   ;; ("f2> l" . counsel-unicode-char)
   ;; ivy-based interface to sheel and system tools
   ;; ("C-c g" . counsel-git)
   ;; ("C-c j" . counsel-git-grep)
   ;; ("C-c k" . counsel-ag)
   ;; ("C-x l" . counsel-locate)
   ;; ("C-S-o" . counsel-rhytmbox)
   ("C-c C-r" . ivy-resume)) ; resumes the last ivy-based completion
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "))

;; (use-package helm ; completely changed tab completion (kill-ring, buffers, find-file)
;;   :ensure t ;; auto install package
;;   :pin melpa-stable
;;   :diminish helm-mode
;;   :init
;;   (require 'helm-config) ; setup helm (keybindings, etc...)
;;   (setq helm-idle-delay       0.0 ; update fast sources immediately
;;         helm-input-idle-delay 0.01 ; update fast sources immediately
;;         helm-quick-update     t ; do not display invisible candidates
;;         helm-M-x-requires-pattern nil
;;         helm-ff-skip-boring-files t ; hide files defined by helm-boring-file-regexp-list
;;         helm-boring-file-regexp-list
;;         '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "~$"
;;           "\\.so$" "\\.a$" "\\.elc$" "\\.fas$" "\\.fasl$" "\\.pyc$" "\\.pyo$")

;;         helm-M-x-fuzzy-match   t ; optional fuzzy matching for helm-M-x
;;         ;; optional fuzzy matching for helm-mini
;;         helm-buffers-fuzzy-matching t
;;         helm-recentf-fuzzy-match    t)
;;     (helm-mode)
;;   :bind (("M-x" . helm-M-x)
;;          ("M-y" . helm-show-kill-ring)
;;          ("C-x b" . helm-mini)
;;          ("C-x C-f" . helm-find-files)
;;          ("C-x r b" . helm-bookmarks)
;; 	 :map helm-map
;;          ("<tab>" . helm-execute-persistent-action) ; rebind tab to do persistent action
;;          ;; ("C-i" . helm-execute-persistent-action) ; make TAB work in terminal
;;          ("C-z" . helm-select-action)) ; list actions using C-z
;;   :config
;;   (use-package helm-projectile
;;     :ensure t ;; auto install package
;;     :pin melpa-stable
;;     :init
;;     ;; (setq projectile-indexing-method 'alien) ; force windows to use external indexing (causes freezes)
;;     ;; after hlem-projectile-switch-project finishes execution, call helm-projectile-find-file (instead of projectile's version)
;;     (setq projectile-switch-project-action 'helm-projectile-find-file)
;;     :config
;;     (projectile-mode) ; make projectile automatically rememeber projects that you access files in
;;     (setq projectile-completion-system 'helm) ; use helm for projectile's completion system
;;     (helm-projectile-on))) ; enables helm-projectile (override projectile commands)

(use-package flycheck ;; syntax checker
  :ensure t ;; auto install package
  :pin melpa-stable
  :diminish global-flycheck-mode
  :config
  (global-flycheck-mode)) ; enables global-flycheck-mode

(use-package auto-complete ;; adds auto-completion
  :ensure t ;; auto install package
  :pin melpa-stable
  :config
  (require 'auto-complete-config)
  (setq ac-auto-start 2
        ac-delay 2)
  (ac-config-default)) ; enables global-auto-completion-mode and set defautls

(use-package rainbow-delimiters
  :ensure t ;; auto install package
  :pin melpa-stable
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; highlightes matching parentheses specific colors when cursor is inside
;; (use-package highlight-parentheses
  ;; :config
  ;; creates a global mode for highlight-parentheses-mode and enables it
  ;; (define-globalized-minor-mode global-highlight-parentheses-mode
  ;;   highlight-parentheses-mode
  ;;   (lambda ()
  ;;     (highlight-parentheses-mode t)))
  ;; (global-highlight-parentheses-mode t)
  ;; )


;;------------------------------------------------------------------------------
;; General
;;------------------------------------------------------------------------------
(setq inhibit-startup-screen t) ; disable startup screen

(setq-default indent-tabs-mode nil) ; TAB inserts SPACE's

(setq auto-save-default nil); disable auto save
(setq make-backup-files nil) ; disable backup

;;------------------------------------------------------------------------------
;; Keybindings
;;------------------------------------------------------------------------------
(global-set-key (kbd "C-!") 'shell) ;; '<CTRL> + !' opens up shell

;;------------------------------------------------------------------------------
;; Theme
;;------------------------------------------------------------------------------
(load-theme 'tango-dark) ; loads the specified theme

(show-paren-mode 1) ; highlights matching parenthesis
;; (linum-mode 1) ; shows line numbers on the left side of the buffer
(menu-bar-mode -1) ; disables the menu bar
(tool-bar-mode -1) ; disables the tool bar
(scroll-bar-mode -1) ; disables the scroll bar

;; (with-temp-file "packages.txt" (insert (format "%S" package-activated-list)))


;;------------------------------------------------------------------------------
;; Custom - created when installing plugins
;;------------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auto-complete flycheck helm-projectile helm evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
