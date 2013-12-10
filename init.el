(defconst emacs-start-time (current-time))

(unless noninteractive
  (message "Loading %s..." load-file-name))


(unless window-system
  (if (not (eq system-type 'windows-nt))
      (load "~/.emacs.d/console-emacs-only.el")))
(if window-system (load "~/.emacs.d/xemacs-only.el"))


;; extend the path on windows
(if (eq system-type 'windows-nt)
    (setenv "PATH"
	    (concat "C:/Program Files (x86)/Git/bin" ";" (getenv "PATH")) ))


;; mac
(if (eq system-type 'darwin)
    (progn
      (setenv "PATH" (concat
                      "/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:" (getenv "PATH")))
      (setq exec-path (cons "/usr/local/bin" exec-path))
      )
  )


;; MAC needs this
(setq mac-command-modifier 'meta)


;;;;;;;
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/elpa/")
;; (add-to-list 'load-path "~/.emacs.d/magit/")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/plugins/mark-multiple/")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")
(add-to-list 'load-path "~/.emacs.d/plugins/js2-mode/")
(add-to-list 'load-path "~/.emacs.d/plugins/monky/")


(require 'bind-key)
(require 'use-package)
;;;;;;;


(require 'cl-lib)


;; mmm & mako mode
;; (require 'mmm-auto)
;; (setq mmm-global-mode 'maybe)

;; (load "mmm-mako.el")
;; (mmm-add-mode-ext-class 'html-mode "\\.mak\\'" 'mako)
(add-to-list 'auto-mode-alist '("\\.mak\\'" . html-mode))


(use-package
 tools
 :init
 (progn
   (bind-key "C-x M-w M-h" 'html-tag-wrap-text)
   (bind-key "C-x M-w M-d" 'django-tag-wrap-text)
   (bind-key "C-x M-w M-f" 'wrap-text)
   (bind-key "C-/" 'comment-or-uncomment-region-or-line)
   (bind-key "C-<f2>" 'multi-occur-in-this-mode)
   (bind-key "C-c d" 'duplicate-current-line-or-region)

   (bind-key "C-c t t" 'toggle-truncate-lines)
   (bind-key "S-M-<left>" 'shrink-window-horizontally)
   (bind-key "S-M-<right>" 'enlarge-window-horizontally)
   (bind-key "S-M-<down>" 'shrink-window)
   (bind-key "S-M-<up>" 'enlarge-window)

   (bind-key "M-N" 'shrink-window)
   (bind-key "M-P" 'enlarge-window)

   ;; switching between windows
   (bind-key "C-c <C-right>" 'windmove-right)
   (bind-key "C-c <C-left>" 'windmove-left)
   (bind-key "C-c <C-up>" 'windmove-up)
   (bind-key "C-c <C-down>" 'windmove-down)

   (bind-key "C-c <right>" 'windmove-right)
   (bind-key "C-c <left>" 'windmove-left)
   (bind-key "C-c <up>" 'windmove-up)
   (bind-key "C-c <down>" 'windmove-down)

   ;; (bind-key "C-x f" 'recentf-ido-find-file)
   ))
(load "~/.emacs.d/keys.el")

;; (require 'sunrise-commander)
;; (require 'sunrise-x-tree)


(setq backup-inhibited t) ; turn off backup files
(setq x-select-enable-clipboard t)
(setq line-number-mode t)
(setq column-number-mode t)
(setq visible-bell nil)
(setq enable-recursive-minibuffers t)
(setq scroll-step 1)
(setq auto-save-default nil)

(show-paren-mode 1)
(menu-bar-mode -1)
(delete-selection-mode 1) ; delete seleted text when typing
(global-hl-line-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(set-face-bold-p 'font-lock-keyword-face t)
;; (set-face-italic-p 'font-lock-comment-face t)
;; (set-face-italic-p 'italic nil)

(setq-default show-trailing-whitespace t)
(setq-default truncate-lines t)
(setq-default indent-tabs-mode nil)

(setq dabbrev-case-fold-search nil)
(setq dabbrev-case-replace t)

;; linum mode
;; (global-linum-mode -1)  ;; I'm turning it on only for code edition see below
(setq linum-format "%d ")


;; eshell - I do not use it as much
;; (defun my-eshell-hook()
;;   (setq-default show-trailing-whitespace nil))
;; (add-hook 'eshell-mode-hook 'my-eshell-hook)


;; escreen
;; (load "escreen")
;; (escreen-install)


;; C, C++ indentation level
(setq c-default-style "bsd"
      c-basic-offset 4)


;; dired
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
		'("\\.zip\\'" ".zip" "unzip")))
(setq dired-dwim-target t)


;; devils's pie mode
;; (add-to-list 'auto-mode-alist '("\\.ds\\'" . lisp-mode))


(require 'bm)
(setq bm-electric-show nil)
(global-set-key (kbd "<C-f1>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)


(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:special-display-config
      '(("*Help*")
        ("*bm-bookmarks*")
        ("*Messages*")
        ("*Occur*")
        ("*Completions*")
        ("*Ibuffer*")
        ("*image-dired*")
        ))
(global-set-key (kbd "C-c q") popwin:keymap)


(use-package
 python-mode
 :mode (("\\.py" . python-mode))
 )


(when (not (boundp 'tramp-list-remote-buffers))
  (defun tramp-list-remote-buffers ()
    ()
    ))


(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
     ; Make sure it's not a remote buffer or flymake would not work
     (when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "pyflakes" (list temp-file)))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))


(use-package smooth-scrolling)
(use-package coffee-mode)
(use-package clojure-mode)
(use-package hl-tags-mode)
(use-package ack)


;; (use-package
;;  tramp
;;  :defer t
;;  :config
;;  (progn
;;    (setq tramp-default-method "ssh")
;;    ))
(setq tramp-mode nil)


(use-package
 uniquify
 :config
 (progn
   (setq uniquify-buffer-name-style 'forward)
   (setq uniquify-separator "/")
   (setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
   (setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
   ))


(require 'highlight-symbol)
(setq highlight-symbol-idle-delay 0.1)
(global-set-key (kbd "C-1") 'highlight-symbol-at-point)
(global-set-key (kbd "C-3") 'highlight-symbol-next)
(global-set-key (kbd "C-2") 'highlight-symbol-prev)


;; (require 'magit)
(eval-after-load 'magit ;; change magit diff colors
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (set-face-background 'magit-item-highlight "#2e3436")
     (when (not window-system)
       (set-face-background 'magit-item-highlight "gray13"))))
(global-set-key (kbd "C-x g") 'magit-status)


;; (require 'monky)
;; (eval-after-load 'monky ;; change monky diff colors
;;   '(progn
;;      (set-face-foreground 'monky-diff-add "green3")
;;      (set-face-foreground 'monky-diff-del "red3")
;;      ))
;; (setq monky-process-type 'cmdserver)
;; (global-set-key (kbd "C-x C-g h") 'monky-status)


(use-package
 php-mode
 :defer t
 :mode ("\\.php\\'" . php-mode)
 )


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


(use-package
 text-translator
 :defer t
 :commands (text-translator text-translator-translate-last-string)
 :init
 (progn
   (setq text-translator-display-popup t)
   (setq text-translator-default-engine "google.com_enpl")
   (bind-key "C-x M-t" 'text-translator)
   (bind-key "C-x M-T" 'text-translator-translate-last-string)
   ))


(require 'dropdown-list)
(require 'yasnippet)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")
(yas/initialize)

;; XXX: This does not work
;; (use-package
;;  yasnippet
;;  :if (not noninteractive)
;;  :diminish yas/minor-mode
;;  :commands (yas/minor-mode yas/expand)
;;  :init
;;  (progn
;;    (bind-key "TAB" 'yas/expand))
;;  :config
;;  (progn
;;    (use-package dropdown-list)
;;    (yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")
;;    (yas/initialize))
;;  )

(require 'recentf)
(recentf-mode 1)


(use-package
 ido
 :commands
 (recentf-list
  recentf-load-list
  recentf-ido-find-file
  recentf-open-files
  ido-find-file
  ido-goto-bookmark
  ido-goto-symbol)
 :init
 (progn
   (bind-key "M-i" 'ido-goto-symbol)
   (bind-key "C-x f" 'recentf-ido-find-file))
 :config
 (progn
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
 ))


(use-package
 smex
 :defer t
 :commands (smex smex-major-mode-commands smex-update-and-run)
 :init
 (progn
   (bind-key "M-x" 'smex)
   (bind-key "M-X" 'smex-major-mode-commands)
   (bind-key "C-c M-x" 'smex-update-and-run)
   (bind-key "C-c C-c M-x" 'execute-extended-command)) ;Old M-x.
 :config
 (progn
   (smex-initialize)
   ))


(use-package
 apache-mode
 :mode
 (("\\.htaccess\\'"                   . apache-mode)
  ("httpd\\.conf\\'"                  . apache-mode)
  ("srm\\.conf\\'"                    . apache-mode)
  ("access\\.conf\\'"                 . apache-mode)
  ("sites-\\(available\\|enabled\\)/" . apache-mode)
  ))


(use-package
 django-mode
 :defer t
 :mode (
   ("\\.html\\'" . django-mode)
   ("\\.dhtml\\'" . django-mode)
 )
 :config
 (progn
   (defun my-django-mode-hook ()
     (setq tab-width 4)
     (lambda()
       (setq sgml-basic-offset 4)
       (setq indent-tabs-mode t))
     )
   (add-to-list 'django-mode-hook 'my-django-mode-hook)
   ))


(use-package
 d-mode
 :mode ("\\.d\\'" . d-mode))


(use-package
 less-mode
 :mode (
   ("\\.less\\'" . less-mode)
   ("\\.scss\\'" . less-mode)  ;; just workaround for a while
 )
 :config
 (progn
   (defun my-less-mode-hook ()
     (setq less-compile-at-save nil))
   (add-to-list 'less-mode-hook 'my-less-mode-hook)
   ))


;; javascript mode (js2-mode)
(require 'js2-mode)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(defun my-js-mode-hook ()
  (setq tab-width 4)
  (setq js-indent-level 4)
  (setq indent-tab-mode nil)
  )
(add-hook 'js-mode-hook 'my-js-mode-hook)


;; js docs - DOES NOT WORK
;; (use-package
;;  js-doc
;;  :commands (js-doc-insert-function-doc js-doc-insert-tag)
;;  :init
;;  (progn
;;    (bind-key "C-c i" 'js-doc-insert-function-doc js2-mode-map)
;;    (bind-key "@" 'js-doc-insert-tag js2-mode-map)))


;; nsi-mode
(use-package
 nsis-mode
 :init
 (progn
   (defalias 'nsi-point 'py-point))
 :mode
 (("\\.\\([Nn][Ss][Ii]\\)$" . nsis-mode)
  ("\\.\\([Nn][Ss][Hh]\\)$" . nsis-mode))
 :config
 (progn
   (autoload 'nsis-mode "nsis-mode" "NSIS mode" t)))


;; gnus configuration
;; (setq gnus-select-method '(nnml ""))
;; (setq gnus-permanently-visible-groups "mail")
;; (setq gnus-select-method '(nnimap "gmail"
;; 				  (nnimap-address "imap.gmail.com")
;; 				  (nnimap-server-port 993)
;; 				  (nnimap-stream ssl)))

;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.gmail.com" 587 "kuba.janoszek@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587
;;       smtpmail-local-domain "janoszek.com")


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
(require 'package)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;; (when
;;     (load (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (progn
;;     (add-to-list 'package-archives
;;                  '("gnu" . "http://elpa.gnu.org/packages/") t)
;;     (add-to-list 'package-archives
;;                  '("marmalade" . "http://marmalade-repo.org/packages/") t)
;;     (add-to-list 'package-archives
;;                  '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;     (package-initialize)
;;     ))


(when (not package-archive-contents)
  (package-refresh-contents))


;; cycle through buffers
;; (global-set-key (kbd "<C-tab>") 'bury-buffer)



;; bat-mode - NOT IN HEAVY USE
;; (setq auto-mode-alist
;;       (append
;;        (list (cons "\\.[bB][aA][tT]$" 'bat-mode))
;;        ;; For DOS init files
;;        (list (cons "CONFIG\\."   'bat-mode))
;;        (list (cons "AUTOEXEC\\." 'bat-mode))
;;        auto-mode-alist))
;;
;;   (autoload 'bat-mode "bat-mode"
;;      "DOS and WIndows BAT files" t)


(use-package ace-jump-mode
  :bind ("C-c C-SPC" . ace-jump-mode))


;; CODING HOOK
(defun my-coding-mode-hook()
  (hl-line-mode 1)
  (linum-mode 1)
  (highlight-symbol-mode)
  (flymake-mode 1)
  )
(add-hook 'java-mode-hook       'my-coding-mode-hook)
(add-hook 'c-mode-hook          'my-coding-mode-hook)
(add-hook 'c++-mode-hook        'my-coding-mode-hook)
(add-hook 'clojure-mode-hook    'my-coding-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-coding-mode-hook)
(add-hook 'sh-mode-hook         'my-coding-mode-hook)
(add-hook 'ruby-mode-hook       'my-coding-mode-hook)
(add-hook 'js-mode-hook         'my-coding-mode-hook)
(add-hook 'js2-mode-hook        'my-coding-mode-hook)


(defun my-python-mode-hook()
  (my-coding-mode-hook)
  (modify-syntax-entry ?_ "_" python-mode-syntax-table)
)
(add-hook 'python-mode-hook 'my-python-mode-hook)


(defun my-html-coding-hook()
  (my-coding-mode-hook)
  (setq sgml-basic-offset 4)
  )
(add-hook 'html-mode-hook 'my-html-coding-hook)


;; mark-multiple
;; (require 'inline-string-rectangle)
;; (global-set-key (kbd "C-x r t") 'inline-string-rectangle)


;; (require 'mark-more-like-this)
;; (global-set-key (kbd "C-x M-m") 'mark-more-like-this)
;; (global-set-key (kbd "C-<") 'mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mark-next-like-this)
;; (global-set-key (kbd "C-*") 'mark-all-like-this)
;; ^^ like the other two, but takes an argument (negtive is previous)


;; sessions
;; (load "~/.emacs.d/sessions.el")

(require 'projectile)
;; (require 'projectile-autoloads)
(projectile-global-mode)


(require 'popup)


;; compile on demand
(defun -compile-command(subcommands-to-run)
  (concat "~/bin/compile"
          subcommands-to-run
          (projectile-project-root)
          " "
          (buffer-file-name)
          " "
          "\"" (what-cursor-position) "\""
          ))


(defun compile-current-all()
  (interactive)
  (compilation-start (-compile-command " pep8,nosetests-project ")))
(global-set-key (kbd "C-c c a") 'compile-current-all)


(defun compile-current-pep8()
  (interactive)
  (compilation-start (-compile-command " pep8 ")))
(global-set-key (kbd "C-c c p") 'compile-current-pep8)


(defun compile-current-nosetests()
  (interactive)
  (compilation-start (-compile-command " nosetests ")))
(global-set-key (kbd "C-c c t") 'compile-current-nosetests)
