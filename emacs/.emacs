;;------------------------------------------------------------------------------
;; Packages
;;------------------------------------------------------------------------------
(require 'package)
(setq package-enable-at-startup nil)
;; add mepla repositories to the package-archives list
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
  (require 'use-package))
(require 'diminish) ; if you use :diminish
(require 'bind-key) ; if you use any :bind variant

;; install required packages
;;---------------------------
(use-package evil ; evil - adds vim-like functionality (vim-mode)
  :ensure t ; auto install package
  :pin melpa ; dependence (goto-chr) does not exists in melpa stable, so use melpa repository instead
  :diminish undo-tree-mode
  :config
  (evil-mode 1)
  ;; adds default emacs behvaiour to the following modes
  (dolist (mode '(ag-mode
                  flycheck-error-list-mode
                  git-rebase-mode))
    (add-to-list 'evil-emacs-state-modes mode))
  ;; actives vim hjkl (+ few other) key-bindings for emacs state in evil-mode
  (evil-add-hjkl-bindings occur-mode-map 'emacs
    (kbd "/")       'evil-search-forward
    (kbd "n")       'evil-search-next
    (kbd "N")       'evil-search-previous
    (kbd "C-d")     'evil-scroll-down
    (kbd "C-u")     'evil-scroll-up
    (kbd "C-w C-w") 'other-window))


;; overhauls search, also includes ivy (completion system)
(use-package swiper
  :ensure t ; auto install package
  :pin melpa-stable
  :diminish ivy-mode
  :init
  (use-package counsel ; contains all counsel* functions which use ivy completion
    :ensure t ; auto install package
    :pin melpa-stable
    :bind
    ;; ivy-based interface to standard commands
    (("M-x" . counsel-M-x)
     ("C-x y" . counsel-yank-pop)
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
    ))
  (ivy-mode 1) ; enable ivy-mode (use ivy completion anywhere completing-read-function is used)
  :bind
  ;; ivy-based interface to standard commands
  (("C-s" . swiper)
   ("C-c C-r" . ivy-resume)) ; resumes the last ivy-based completion
  :config
  (setq ivy-use-virtual-buffers t ; add recent files to buffers list
        ivy-count-format "(%d/%d) ")
  )

(use-package projectile
  :ensure t
  :pin melpa-stable
  :diminish projectile-mode
  :init
  (projectile-global-mode 1) ; make projectile automatically remember projects who's files have been accessed
  :config
  (setq projectile-completion-system 'ivy)
  ;; (setq projectile-indexing-method 'alien) ; force windows to use external indexing (git, etc; can cause issues)
  )

(use-package flycheck ; syntax checker
  :ensure t ; auto install package
  :pin melpa-stable
  :config
  ;; (global-flycheck-mode) ; enables global-flycheck-mode
  (add-hook 'prog-mode-hook #'flycheck-mode)) ; enable flycheck-mode on any programming language)

(use-package auto-complete ; adds auto-completion
  :ensure t ; auto install package
  :pin melpa-stable
  :config
  (require 'auto-complete-config)
  ;; (setq ac-auto-start 2
  ;;      ac-delay 2)
  (ac-config-default)) ; enables global-auto-completion-mode and set defautls

(use-package rainbow-delimiters
  :ensure t ; auto install package
  :pin melpa-stable
  :config
  ;; use more saturated colors
  (require 'cl-lib)
  (require 'color)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30)))
  ;; unmatched parens are displayed in bold red and with a strike through
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil
                      :foreground 'unspecified
                      :inherit 'error
                      :strike-through t)
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)) ; enable rainbow-delimiters-mode on any programming language

;; (use-package racket-mode
  ;; :ensure t ; auto install package
  ;; :pin melpa
  ;; )


;;------------------------------------------------------------------------------
;; General
;;------------------------------------------------------------------------------
(setq inhibit-startup-screen t) ; disable startup screen

(setq auto-save-default nil); disable auto save
;; (setq make-backup-files nil) ; disable backup
;; stop littering everywhere with save files, put them somewhere
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; (desktop-save-mode 1) ; remember what I had open when I quit

(setq-default indent-tabs-mode nil) ; TAB inserts SPACE's
(fset 'yes-or-no-p 'y-or-n-p) ; changes all yes/no questions to y/n type
;; delete trailing white-space from entire buffer before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; list all plugins installed
;; (with-temp-file "~/.emacs.d/packages.txt" (insert (format "%S" package-activated-list)))

;;------------------------------------------------------------------------------
;; Variables
;;------------------------------------------------------------------------------
(setq user-emacs-file "~/.emacs.d/init.el") ; path to 'init.el' file
(setq user-emacs-file "~/.emacs") ; path to '.emacs' file


;;------------------------------------------------------------------------------
;; Functions
;;------------------------------------------------------------------------------
;; opens 'init.el' file in another window
(defun find-user-init-file ()
  "Edit the 'user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))

;; opens '.emacs' file in another window
(defun find-user-emacs-file ()
  "Edit the 'user-emacs-file', in another window."
  (interactive)
  (find-file-other-window user-emacs-file))


;;------------------------------------------------------------------------------
;; Keybindings
;;------------------------------------------------------------------------------
(global-set-key (kbd "C-!") 'shell) ; opens up the default shell

;; Procedure key-bindings
;;--------------------------
(global-set-key (kbd "C-c i") 'find-user-init-file)
(global-set-key (kbd "C-c e") 'find-user-emacs-file)


;;------------------------------------------------------------------------------
;; Theme
;;------------------------------------------------------------------------------
(load-theme 'tango-dark) ; loads the specified theme

(menu-bar-mode -1) ; disables the menu bar
(tool-bar-mode -1) ; disables the tool bar
(scroll-bar-mode -1) ; disables the scroll bar

(show-paren-mode 1) ; highlights matching parenthesis
(column-number-mode 1) ; display column/row of cursor in mode-line

(add-hook 'prog-mode-hook #'linum-mode) ; shows line numbers on the left side of the buffer


;;------------------------------------------------------------------------------
;; Python
;;------------------------------------------------------------------------------
;; disables python native completion setup failed
(setq python-shell-completion-native-enable nil)

;;------------------------------------------------------------------------------
;; Custom - created when installing plugins
;;------------------------------------------------------------------------------
