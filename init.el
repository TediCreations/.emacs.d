;;------------------------------------------------------------------------------
;;Init pachage manager
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
;;(add-to-list 'package-archives
;;	     '("melpa2" . "http://www.mirrorservice.org/sites/melpa.org/packages/"))
;;(add-to-list 'package-archives
;;	     '("melpa3" . "http://www.mirrorservice.org/sites/stable.melpa.org/packages/"))

(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

;;------------------------------------------------------------------------------
;;Workplace
(setq inhibit-startup-message t);;Do not shown start-up screen
(tool-bar-mode -1);;Remove toolbar
(desktop-save-mode 1);;Save session

;;------------------------------------------------------------------------------
;;Editor
(global-linum-mode t);;Show line numbers <
(column-number-mode t);;Show the column number V

;;Search
;; it looks like counsel is a requirement for swiper
(use-package counsel
  :ensure t)

(use-package swiper
  :ensure try
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-load-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history) ))

;;Theme
(use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))

;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(load-theme 'tedi t)

;;-------------------------------------------------------------------------------
;;Test
;;(set-frame-parameter nil 'fullscreen 'fullboth)
(scroll-bar-mode -1)

;;(set-face-attribute 'default nil :font "OCR A Extended" )
;;(set-frame-font "OCR A Extended" nil t)3

;;------------------------------------------------------------------------------
;;Let's you try packages without installing them
(use-package try
	:ensure t)

;;Brings up help on key combinations
(use-package which-key
	:ensure t 
	:config	(which-key-mode))

;;------------------------------------------------------------------------------
;;Windows
(winner-mode 1);;Remember old configuration
(windmove-default-keybindings);;Enables traversing througth windows with shift+arrow keys
(use-package ace-window
	:ensure t 
	:init
	(progn
	  (global-set-key [remap-other-window] 'ace-window)
	  ))

;;------------------------------------------------------------------------------
;;Buffers
;; using swiper so ido no longer needed
;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
;;(ido-mode 1)

(defalias 'list-buffers 'ibuffer)
;;(defalias 'list-buffers 'ibuffer-other-window)

;;------------------------------------------------------------------------------
;;Autocomplete
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;; Tags for code navigation
(use-package ggtags
  :ensure t
  :config 
  (add-hook 'c-mode-common-hook
	    (lambda ()
	      (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
		(ggtags-mode 1))))
  )

;;------------------------------------------------------------------------------
;;Generated
