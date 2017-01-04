(require 'package)

(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("sunrise" . "http://joseito.republika.pl/sunrise-commander/"))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(package-initialize)

(require 'auto-complete)

(require 'auto-complete-config)
(ac-config-default)

(require 'company)
(global-company-mode t)
(global-set-key (kbd "C-<tab>") 'company-complete)
;; (global-set-key (kbd "C-c C-y") 'company-yasnippet)

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'ido)
(ido-mode t)

(require 'smartparens)
(smartparens-global-mode t)

(require 'anzu)
(global-anzu-mode t)

(require 'linum)
(global-linum-mode t)
;; (setq linum-format "%4d")
(defcustom linum-disabled-modes-list '(eshell-mode shell-mode dired-mode doc-view-mode)
  "List of modes disabled when global linum mode is on."
  :type '(repeat (sexp :tag "Major mode"))
  :tag "Major modes for linum disabling."
  :group 'linum)
(defun linum-on ()
  "When linum is running globally, disable line number in modes defined in `linum-disabled-modes-list'. Changed by linum-off."
  (unless (or
	   (minibufferp)
	   (member major-mode linum-disabled-modes-list))
    (linum-mode t)))

;;doesn't work good
(require 'jedi)
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq jedi:server-command '("/home/whentheycry/.emacs.d/.python-environments/default/bin/jediepcserver"))
;;(eval-after-load "jedi" '(setq jedi:server-command (list "/path/to/emacs-jedi/bin/python" jedi:server-script)))

;;for cedet
(global-ede-mode 1)
(require 'semantic/sb)
(semantic-mode 1)

;; Autocomplete
(require 'auto-complete-config)
(auto-complete-mode t)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)
;; define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
 ;; (add-to-list 'achead:include-directories ' )
 )
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(package-selected-packages
   (quote
    (auto-complete-c-headers yasnippet auto-complete auto-complete-clang-async web-mode arduino-mode jedi anzu smartparens flycheck company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
