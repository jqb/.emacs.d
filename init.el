(unless window-system
  (if (not (eq system-type 'windows-nt))
      (load "~/.emacs.d/console-emacs-only.el")
    )
  )
(if window-system (load "~/.emacs.d/xemacs-only.el"))

;; extend the path on windows
(if (eq system-type 'windows-nt)
    (setenv "PATH"
	    (concat
	     "C:/Program Files (x86)/Git/bin" ";"
	     (getenv "PATH")
	     )
	    )
  )

(setq x-select-enable-clipboard t)
(setq-default show-trailing-whitespace t)
(setq-default truncate-lines t)
(setq line-number-mode t)
(setq column-number-mode t)
;; (global-linum-mode 1)
;; (tool-bar-mode nil)
(setq scroll-step 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(global-hl-line-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(global-set-key [f12] 'menu-bar-mode)
(setq auto-save-default nil)
(show-paren-mode 1)
(set-face-bold-p 'font-lock-keyword-face t)
;; (set-face-italic-p 'font-lock-comment-face t)
;; (set-face-italic-p 'italic nil)
(setq visible-bell nil)
(setq enable-recursive-minibuffers t)
(delete-selection-mode 1) ; delete seleted text when typing


(load "~/.emacs.d/tools.el")
(load "~/.emacs.d/keys.el")
(add-to-list 'load-path "~/.emacs.d/elpa/")
(add-to-list 'load-path "~/.emacs.d/magit/")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")


;; C, C++ indentation level
(setq c-default-style "bsd"
      c-basic-offset 4)


;; dired
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
		'("\\.zip\\'" ".zip" "unzip"))
  )


;; devils's pie mode
(add-to-list 'auto-mode-alist '("\\.ds\\'" . lisp-mode))


(require 'python-mode)
;; python-mode
;; (defadvice python-calculate-indentation (around outdent-closing-brackets)
;;   "Handle lines beginning with a closing bracket and indent them so that
;; they line up with the line containing the corresponding opening bracket."
;;   (save-excursion
;;     (beginning-of-line)
;;     (let ((syntax (syntax-ppss)))
;;       (if (and (not (eq 'string (syntax-ppss-context syntax)))
;;                (python-continuation-line-p)
;;                (cadr syntax)
;;                (skip-syntax-forward "-")
;;                (looking-at "\\s)"))
;;           (progn
;;             (forward-char 1)
;;             (ignore-errors (backward-sexp))
;;             (setq ad-return-value (current-indentation)))
;;         ad-do-it))))
;; (ad-activate 'python-calculate-indentation)


(require 'projectile)
(projectile-global-mode)


(require 'recentf)
(recentf-mode 1)


(require 'smooth-scrolling)
(require 'coffee-mode)
(require 'clojure-mode)
(require 'hl-tags-mode)
(require 'ack)
(require 'tramp)
(setq tramp-default-method "ssh")


(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers


(require 'highlight-symbol)
(global-set-key (kbd "C-1") 'highlight-symbol-at-point)
(global-set-key (kbd "C-3") 'highlight-symbol-next)
(global-set-key (kbd "C-2") 'highlight-symbol-prev)


(require 'magit)
(eval-after-load 'magit ;; change magit diff colors
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (set-face-background 'magit-item-highlight "#2e3436")
     (when (not window-system)
       (set-face-background 'magit-item-highlight "black"))))
(global-set-key (kbd "C-x g") 'magit-status)


(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))


;; java mode
(defun my-java-mode-hook ()
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-close 0)
  (setq tab-width 4))
(add-hook 'java-mode-hook 'my-java-mode-hook)


;; Org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)
(setq org-agenda-files (list "~/.org/"))
(setq org-cycle-include-plain-lists t)


(require 'yasnippet)     ;; not yasnippet-bundle
(require 'dropdown-list) ;; not yasnippet-bundle
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")
(yas/initialize)


(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer (quote never))
(setq ido-enable-last-directory-history nil)
(setq ido-enable-regexp nil)
(setq ido-max-directory-size 300000)
(setq ido-max-file-prompt-width 0.1)
;; (setq ido-use-filename-at-point (quote guess))
(setq ido-use-url-at-point t)
(setq ido-use-virtual-buffers t)
(setq ido-ignore-files '("\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./" "\\.dep$" "\\.pyc$" "*.py~"))
(define-key ido-file-dir-completion-map [(meta control ?b)] 'ido-goto-bookmark)
(global-set-key (kbd "M-i") 'ido-goto-symbol)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)


(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update-and-run)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;Old M-x.


(require 'apache-mode)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))


(require 'django-mode)
(defun my-django-mode-hook ()
  (setq tab-width 2))
(add-to-list 'auto-mode-alist '("\\.html\\'" . django-mode))
(add-to-list 'django-mode-hook 'my-django-mode-hook)


(require 'd-mode)
(add-to-list 'auto-mode-alist '("\\.d\\'" . d-mode))


(require 'less-mode)
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-mode))


;; javascript mode
(defun my-js-mode-hook ()
  (setq tab-width 4)
  (setq js-indent-level 4)
  (setq indent-tab-mode t)
  )
(add-hook 'js-mode-hook 'my-js-mode-hook)


;; js docs
(require 'js-doc)
(add-hook 'js2-mode-hook
          '(lambda ()
	     (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
	     (define-key js2-mode-map "@" 'js-doc-insert-tag))
)


;; nsi-mode
(defalias 'nsi-point 'py-point)
(require 'nsis-mode)
(autoload 'nsis-mode "nsis-mode" "NSIS mode" t)
(setq auto-mode-alist (append '(("\\.\\([Nn][Ss][Ii]\\)$" .
                                 nsis-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.\\([Nn][Ss][Hh]\\)$" .
                                 nsis-mode)) auto-mode-alist))


;; gnus configuration
;; (setq gnus-select-method '(nnml ""))
(setq gnus-permanently-visible-groups "mail")
(setq gnus-select-method '(nnimap "gmail"
				  (nnimap-address "imap.gmail.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "kuba.janoszek@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "janoszek.com")


;; (setq starttls-use-gnutls nil)
;; (setq send-mail-function 'smtpmail-send-it
;;       message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials
;;       '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       (expand-file-name "~/.authinfo")
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587
;;       smtpmail-debug-info t)
;; (require 'smtpmail)


;; csharp <= causes problems with dired, because I do not use flymake...
;; more info: http://code.google.com/p/csharpmode/issues/detail?id=8
;; (require 'csharp-mode)
;; (autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
;; (setq auto-mode-alist
;;       (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))


;; ELPA
;; (when
;;     (load
;;      (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))

;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; (when (not package-archive-contents)
;;   (package-refresh-contents))


;; cycle through buffers
;; (global-set-key (kbd "<C-tab>") 'bury-buffer)



;; bat-mode
(setq auto-mode-alist
      (append
       (list (cons "\\.[bB][aA][tT]$" 'bat-mode))
       ;; For DOS init files
       (list (cons "CONFIG\\."   'bat-mode))
       (list (cons "AUTOEXEC\\." 'bat-mode))
       auto-mode-alist))

(autoload 'bat-mode "bat-mode"
  "DOS and WIndows BAT files" t)


(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
