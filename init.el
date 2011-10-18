(if (string-match "GTK+" (emacs-version))
    (load "~/.emacs.d/xemacs-only.el")
  (load "~/.emacs.d/console-emacs-only.el"))


(require 'tramp)
(setq tramp-default-method "ssh")


(setq x-select-enable-clipboard t)
(setq-default show-trailing-whitespace t)
(setq-default truncate-lines t)
(setq line-number-mode t)
(setq column-number-mode t)
;; (global-linum-mode 1)
;; (tool-bar-mode nil)
(menu-bar-mode nil)
(setq scroll-step 1)
(fset 'yes-or-no-p 'y-or-n-p)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(global-set-key [f9] 'menu-bar-mode)
(setq auto-save-default nil)

(show-paren-mode 1)


;; several file with the same name are unique from now on:
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


(set-face-bold-p 'font-lock-keyword-face t)
;; (set-face-italic-p 'font-lock-comment-face t)
;; (set-face-italic-p 'italic nil)


;; Turn off visible-bell
(setq visible-bell nil)


;; ftp support for passive mode
(defvar ange-ftp-hosts-no-pasv '("localhost")
  "*List of hosts that do not need PASV (e.g. hosts within your firewall).
  Used by `ange-ftp-set-passive'.")	; rephrased, added "*" // era

(defun ange-ftp-set-passive ()
  "Function to send a PASV command to hosts not named in the variable
  `ange-ft-hosts-no-pasv'. Intended to be called from the hook variable
  `ange-ftp-process-startup-hook'."	; rephrased significantly // era
  (if (not (member host ange-ftp-hosts-no-pasv))
      (ange-ftp-raw-send-cmd proc "passive")))
(add-hook 'ange-ftp-process-startup-hook 'ange-ftp-set-passive)


;; highlight-symbol
(load "~/.emacs.d/highlight-symbol.el")

;; (global-set-key [(control f3)] 'highlight-symbol-at-point)
;; (global-set-key [f3] 'highlight-symbol-next)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-prev)


;;; git support
;; standard git support
;; (load "/usr/share/doc/git-core/contrib/emacs/git.el")
;; (load "/usr/share/doc/git-core/contrib/emacs/git-blame.el")
;; (load "/usr/share/doc/git-core/contrib/emacs/vc-git.el")
;; (add-to-list 'vc-handled-backends 'GIT)


;; egg
;; (load "~/.emacs.d/egg/egg.elc")
;; (load "~/.emacs.d/egg/egg-grep.elc")
;; (require 'egg)
(load "~/.emacs.d/magit/magit-key-mode.el")
(load "~/.emacs.d/magit/magit-bisect.el")
(load "~/.emacs.d/magit/magit.el")
(load "~/.emacs.d/magit/contrib/magit-classic-theme.el")
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)


;; change magit diff colors
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (set-face-background 'magit-item-highlight "#2e3436")
     (when (not window-system)
       (set-face-background 'magit-item-highlight "black"))))


;; ibuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; php mode
(load "~/.emacs.d/php-mode.el")
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))


;; Smooth scrolling mode
(load "/home/kuba/.emacs.d/smooth-scrolling.elc")


;; javascript mode
(load "~/.emacs.d/javascript.elc")
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(setq javascript-indent-level 2)


;; coffee script mode
(load "~/.emacs.d/coffee-mode.elc")


;; java mode fixxes
(c-set-offset 'arglist-intro 4)
(c-set-offset 'arglist-close 0)


;; devils's pie mode
(add-to-list 'auto-mode-alist '("\\.ds\\'" . lisp-mode))


;; graphviz-mode
;; (load-file "~/.emacs.d/graphviz-dot-mode.elc")


;; Org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)
(setq org-agenda-files (list "~/.org/"))
(setq org-cycle-include-plain-lists t)


;; JSP mode, GSP mode
;; (add-to-list 'auto-mode-alist '("\\.jsp\\'" . html-mode))
;; (add-to-list 'auto-mode-alist '("\\.gsp\\'" . html-mode))

;;
;; (desktop-save-mode 1)


;; yas templates
;; (add-to-list 'load-path "/etc/emacs/site-start.d/plugins")
;; (require 'yasnippet-bundle)
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)     ;; not yasnippet-bundle
(require 'dropdown-list) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")


(load "~/.emacs.d/tools.elc")


(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer (quote never))
(setq ido-enable-flex-matching t)
(setq ido-enable-last-directory-history nil)
(setq ido-enable-regexp nil)
(setq ido-max-directory-size 300000)
(setq ido-max-file-prompt-width 0.1)
(setq ido-use-filename-at-point (quote guess))
(setq ido-use-url-at-point t)
(setq ido-use-virtual-buffers t)


(setq enable-recursive-minibuffers t)
(define-key ido-file-dir-completion-map [(meta control ?b)] 'ido-goto-bookmark)
(defun ido-goto-bookmark (bookmark)
  (interactive
   (list (bookmark-completing-read "Jump to bookmark"
    				   bookmark-current-bookmark)))
  (unless bookmark
    (error "No bookmark specified"))
  (let ((filename (bookmark-get-filename bookmark)))
    (ido-set-current-directory
     (if (file-directory-p filename)
	 filename
       (file-name-directory filename)))
    (setq ido-exit        'refresh
	  ido-text-init   ido-text
	  ido-rotate-temp t)
    (exit-minibuffer)))


(load "~/.emacs.d/ack.elc")
(require 'ack)


(load "~/.emacs.d/smex.elc")
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update-and-run)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;Old M-x.


;; apache mode
(load "~/.emacs.d/apache-mode.elc")
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))


;; GO programing language
;;(load "~/.emacs.d/go-mode.el")
;;(load "~/.emacs.d/go-mode-load.el")
;;(require 'go-mode-load)


;; project management
(load "/home/kuba/.emacs.d/mk-project/mk-project.elc")
(require 'mk-project)

(global-set-key (kbd "C-c p c") 'project-compile)
(global-set-key (kbd "C-c p l") 'project-load)
(global-set-key (kbd "C-c p a") 'project-ack)
(global-set-key (kbd "C-c p g") 'project-grep)
(global-set-key (kbd "C-c p o") 'project-multi-occur)
(global-set-key (kbd "C-c p u") 'project-unload)
(global-set-key (kbd "C-c p f") 'project-find-file-ido) ; or project-find-file
(global-set-key (kbd "C-c p i") 'project-index)
(global-set-key (kbd "C-c p s") 'project-status)
(global-set-key (kbd "C-c p h") 'project-home)
(global-set-key (kbd "C-c p d") 'project-dired)
(global-set-key (kbd "C-c p t") 'project-tags)

(load "/home/kuba/.emacs.d/projects.el")


;; workspace
(load "~/.emacs.d/escreen.el")
(escreen-install)
(load "~/.emacs.d/workspaces.elc")
(define-key global-map (kbd "C-<tab>") 'workspace-controller)


;; let the emacs starter kit to override my settings and add new one
;; (load "~/.emacs.d/emacs-starter-kit/init.el")


;; (load "/home/kuba/.emacs.d/point-stack.el")
;; (require 'point-stack)
;; (global-set-key '[(f5)] 'point-stack-push)
;; (global-set-key '[(f6)] 'point-stack-pop)
;; (global-set-key '[(f7)] 'point-stack-forward-stack-pop)


;; nxhtml-mode and ruby on rails
;; (load  "~/.emacs.d/nxhtml/autostart")
;; (setq mumamo-background-colors nil)

;; (add-to-list 'load-path "~/.emacs.d/nxhtml/util")
;; (require 'mumamo-fun)
;; (setq mumamo-chunk-coloring 'submode-colored)
;; (add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))


;; django-mode
(load "~/.emacs.d/django-mode.elc")
(add-to-list 'auto-mode-alist '("\\.html\\'" . django-mode))


;; d-lang
(load "~/.emacs.d/d-mode.el")
(add-to-list 'auto-mode-alist '("\\.d\\'" . d-mode))


;; clojure
(load "~/.emacs.d/clojure-mode.el")


;; hl-tags-mode
(load "~/.emacs.d/hl-tags-mode.el")


;; gnus configuration
;; (setq starttls-use-gnutls t)
(setq starttls-use-gnutls nil)
(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials
      '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      (expand-file-name "~/.authinfo")
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-debug-info t)
(require 'smtpmail)


;; C, C++ indentation level
(setq c-default-style "bsd"
      c-basic-offset 4)
