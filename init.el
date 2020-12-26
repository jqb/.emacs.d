(defconst emacs-start-time (current-time))


(unless noninteractive (message "Loading %s..." load-file-name))


(setq normalized-system-type
      (replace-regexp-in-string "[/ -]" "_" (format "%s" system-type)))
(setq normalized-system-name
      (replace-regexp-in-string "[/ -]" "_" (format "%s" system-name)))
(setq system-type-file
      (expand-file-name
       (concat "~/.emacs.d/system/" normalized-system-type ".el")
       )
      )
(setq system-machine-file
      (expand-file-name (concat
                         "~/.emacs.d/system/"
                         normalized-system-type
                         "__"
                         normalized-system-name
                         ".el")
       )
      )
(setq custom-file
      (concat
       "~/.emacs.d/custom/custom__"
       normalized-system-type
       "__"
       normalized-system-name
       ".el"
       )
      )
(setq custom-file-fallback "~/.emacs.d/custom/custom.el")


(message "===========================")
(message "VAR: normalized-system-type = %s" normalized-system-type)
(message "VAR: normalized-system-name = %s" normalized-system-name)
(message "VAR: system-type-file       = %s" system-type-file)
(message "VAR: system-machine-file    = %s" system-machine-file)
(message "VAR: custom-file            = %s" custom-file)
(message "VAR: custom-file-fallback   = %s" custom-file-fallback)
(message "===========================")


;; This is only for debugging purposes if somethings' would fail
;; during the loading of init.el file.
;;
;; (load "~/.emacs.d/keys.el" 'noerror)


;; SYSTEM :: Load system dependent file
(if (file-exists-p system-type-file)
    (progn
      (message "SYSTEM FILE %s exists. It will be loaded." system-type-file)
      (load system-type-file)
      )
  (message "SYSTEM %s DOES NOT exists. Nothing to load." system-type-file)
  )
;; END / SYSTEM


;; CUSTOM :: emacs'es own custom file - different on each OS/machine
(if (file-exists-p custom-file)
    (progn
      (message "CUSTOM FILE %s exists. It will be loaded." custom-file)
      )
  (progn
    (message "CUSTOM FILE %s DOES NOT exists. Falling back to %s."
             custom-file
             custom-file-fallback
             )
    (setq custom-file custom-file-fallback)
    )
  )
(load custom-file 'noerror)
;; END / CUSTOM


(unless window-system
  (if (not (eq system-type 'windows-nt))
      (load "~/.emacs.d/console-emacs-only.el")))
(if window-system (load "~/.emacs.d/xemacs-only.el"))


;;;;;;;
;; Emacs 25.5 on windows is complaining that main .emacs.d is on the
;; load-path, so - commenting out
;;
;; (add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/elpa/")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/plugins/js2-mode/")

;; separate directory with plugins - to avoid gitsubmodules nonsense
(add-to-list 'load-path "~/.emacs.plugins/bookmark-plus/")
(add-to-list 'load-path "~/.emacs.plugins/perspective-el/")


(require 'cl-lib)
(require 'bind-key)
(require 'use-package)
(require 'recentf)


;; https://github.com/nex3/perspective-el
;; ~/.emacs.plugins/perspective-el
(require 'perspective)
(persp-mode)


;; The next line seem to cause troubles on some machines
;;(recentf-mode 1)


(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)


;; As found here:
;; https://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name
;; those few lines below should make sure I have all the packages I've
;; previously installed. They were stored in custom.el
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)
;;;;;;;


;; mmm & mako mode
;; (require 'mmm-auto)
;; (setq mmm-global-mode 'maybe)

;; (load "mmm-mako.el")
;; (mmm-add-mode-ext-class 'html-mode "\\.mak\\'" 'mako)
;; (add-to-list 'auto-mode-alist '("\\.mak\\'" . html-mode))


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


;; Less irritating current line highlighting
(global-hl-line-mode -1)
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight nil)


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
(setq wdired-allow-to-change-permissions t)
(setq dired-listing-switches "-lAh1v --group-directories-first")


;; devils's pie mode
;; (add-to-list 'auto-mode-alist '("\\.ds\\'" . lisp-mode))


(require 'bookmark+)


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


(when (not (boundp 'tramp-list-remote-buffers))
  (defun tramp-list-remote-buffers ()
    ()
    ))


(when (load "flymake" t)
  (defun flymake-flake8-init ()
     ; Make sure it's not a remote buffer or flymake would not work
     (when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "~/.local/bin/flake8" (list temp-file)))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-flake8-init))

  (delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
  )


;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;      ; Make sure it's not a remote buffer or flymake would not work
;;      (when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
;;       (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                          'flymake-create-temp-inplace))
;;              (local-file (file-relative-name
;;                           temp-file
;;                           (file-name-directory buffer-file-name))))
;;         (list "~/.local/bin/pyflakes" (list temp-file)))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init))

;;   (delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
;;   )


;; Configure flymake/pylint for Python
;; (when (load "flymake" t)
;;   (defun flymake-pylint-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "~/.local/bin/pylint" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pylint-init)))


(use-package smooth-scrolling)
(use-package coffee-mode)
(use-package clojure-mode)
(use-package hl-tags-mode)
(use-package ack)
(use-package python-mode
  :mode (("\\.py" . python-mode))
  :config
  (progn
    (setq python-indent-guess-indent-offset nil)
    (setq python-indent-offset 4)
    ))


;; For some reason I don't understant, this doesn't work:
;;
;; (use-package
;;  tramp
;;  :defer t
;;  :config
;;  (progn
;;    (setq tramp-default-method "ssh")
;;    ))
;; (setq tramp-mode nil)
(setq tramp-default-method "ssh")


(use-package
 uniquify
 :config
 (progn
   (setq uniquify-buffer-name-style 'forward)
   (setq uniquify-separator "/")
   (setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
   (setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
   ))


(require 'highlight-symbol)
(setq highlight-symbol-idle-delay 0.1)
(global-set-key (kbd "C-1") 'highlight-symbol-at-point)
(global-set-key (kbd "C-3") 'highlight-symbol-next)
(global-set-key (kbd "C-2") 'highlight-symbol-prev)


;; NOTE: looks like new Magit doesn't need / use that (and looks ok
;; anyway) - leaving for now, just to remember
;;
;; (require 'magit)
;; (eval-after-load 'magit ;; change magit diff colors
;;   '(progn
;;      (set-face-foreground 'magit-diff-add "green3")
;;      (set-face-foreground 'magit-diff-del "red3")
;;      (set-face-background 'magit-item-highlight "#2e3436")
;;      (when (not window-system)
;;        (set-face-background 'magit-item-highlight "gray13"))))
(global-set-key (kbd "C-x g") 'magit-status)


;; (require 'monky)
;; (eval-after-load 'monky ;; change monky diff colors
;;   '(progn
;;      (set-face-foreground 'monky-diff-add "green3")
;;      (set-face-foreground 'monky-diff-del "red3")
;;      ))
;; (setq monky-process-type 'cmdserver)
;; (global-set-key (kbd "C-x C-g h") 'monky-status)


;; PHP... not used at all. Let's leave it like that.
;;
;; (use-package
;;  php-mode
;;  :defer t
;;  :mode ("\\.php\\'" . php-mode)
;;  )


(defun my-coding-mode-hook()
  (hl-line-mode 1)
  (linum-mode 1)
  (highlight-symbol-mode)
  (flymake-mode 1)
  )

(add-hook 'c-mode-hook          'my-coding-mode-hook)
(add-hook 'c++-mode-hook        'my-coding-mode-hook)
(add-hook 'clojure-mode-hook    'my-coding-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-coding-mode-hook)
(add-hook 'sh-mode-hook         'my-coding-mode-hook)
(add-hook 'ruby-mode-hook       'my-coding-mode-hook)
(add-hook 'js-mode-hook         'my-coding-mode-hook)
(add-hook 'js2-mode-hook        'my-coding-mode-hook)


(defun my-java-mode-hook ()
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-close 0)
  (setq tab-width 4)
  (my-coding-mode-hook))
(add-hook 'java-mode-hook 'my-java-mode-hook)


(defun my-html-coding-hook()
  (my-coding-mode-hook)
  (setq sgml-basic-offset 4)
  )
(add-hook 'html-mode-hook 'my-html-coding-hook)


(defun my-python-mode-hook()
  (my-coding-mode-hook)
  (modify-syntax-entry ?_ "_" python-mode-syntax-table)
)
(add-hook 'python-mode-hook 'my-python-mode-hook)


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
   (bind-key "C-x f" 'recentf-ido-find-file)
   )
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
  (setq indent-tabs-mode nil)
  )
(add-hook 'js-mode-hook 'my-js-mode-hook)
(add-hook 'js2-mode-hook 'my-js-mode-hook)


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


;; (require 'dropdown-list)  ;; <= previously needed by yasnippet in "plugins"
;; For one of snippets for java:
(defun my/capitalize-first-char (&optional string)
  "Capitalize only the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string nil 1))
          (rest-str   (substring string 1)))
      (concat (capitalize first-char) rest-str))))


(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.plugins/snippets"  ;; my old snippets, as a separate repo now
        ))
(yas/load-directory "~/.emacs.plugins/snippets")
(yas/initialize)


;; For "elpy" :: pip install rope jedi importmagic autopep8 flake8
(setq python-shell-interpreter "python3")
(setq python-shell-completion-native-enable nil)
(elpy-enable)


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


;; mark-multiple
;; (require 'inline-string-rectangle)
;; (global-set-key (kbd "C-x r t") 'inline-string-rectangle)


;; (require 'mark-more-like-this)
;; (global-set-key (kbd "C-x M-m") 'mark-more-like-this)
;; (global-set-key (kbd "C-<") 'mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mark-next-like-this)
;; (global-set-key (kbd "C-*") 'mark-all-like-this)
;; ^^ like the other two, but takes an argument (negtive is previous)


;; (require 'projectile)
;; (require 'projectile-autoloads)
(projectile-global-mode)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)


(require 'popup)


;; compile on demand
;; (defun -compile-command(subcommands-to-run)
;;   (concat "~/bin/compile"
;;           subcommands-to-run
;;           (projectile-project-root)
;;           " "
;;           (buffer-file-name)
;;           " "
;;           "\"" (what-cursor-position) "\""
;;           ))


;; (defun compile-current-all()
;;   (interactive)
;;   (compilation-start (-compile-command " pep8,nosetests-project ")))
;; (global-set-key (kbd "C-c c a") 'compile-current-all)


;; (defun compile-current-pep8()
;;   (interactive)
;;   (compilation-start (-compile-command " pep8 ")))
;; (global-set-key (kbd "C-c c p") 'compile-current-pep8)


;; (defun compile-current-nosetests()
;;   (interactive)
;;   (compilation-start (-compile-command " nosetests ")))
;; (global-set-key (kbd "C-c c t") 'compile-current-nosetests)


(add-hook 'dired-toggle-mode-hook
          (lambda () (interactive)
            (visual-line-mode 1)
            (setq-local visual-line-fringe-indicators '(nil right-curly-arrow))
            (setq-local word-wrap nil)))


;; (require 'flycheck)


;; (defun flycheck-start-command-checker (checker callback)
;;   "Start a command CHECKER with CALLBACK."
;;   (let (process)
;;     (condition-case err
;;         (let* ((program (flycheck-find-checker-executable checker))
;;                (args (flycheck-checker-substituted-arguments checker))
;;                (command (funcall flycheck-command-wrapper-function
;;                                  (cons program args)))
;;                ;; Use pipes to receive output from the syntax checker.  They are
;;                ;; more efficient and more robust than PTYs, which Emacs uses by
;;                ;; default, and since we don't need any job control features, we
;;                ;; can easily use pipes.
;;                (process-connection-type nil))
;;           ;; We pass do not associate the process with any buffer, by
;;           ;; passing nil for the BUFFER argument of `start-process'.
;;           ;; Instead, we just remember the buffer being checked in a
;;           ;; process property (see below).  This neatly avoids all
;;           ;; side-effects implied by attached a process to a buffer, which
;;           ;; may cause conflicts with other packages.
;;           ;;
;;           ;; See https://github.com/flycheck/flycheck/issues/298 for an
;;           ;; example for such a conflict.
;;           (setq process (apply 'start-process (format "flycheck-%s" checker)
;;                                nil command))
;;           (setf (process-sentinel process) #'flycheck-handle-signal)
;;           (setf (process-filter process) #'flycheck-receive-checker-output)
;;           (set-process-query-on-exit-flag process nil)
;;           ;; Remember the syntax checker, the buffer and the callback
;;           (process-put process 'flycheck-checker checker)
;;           (process-put process 'flycheck-callback callback)
;;           (process-put process 'flycheck-buffer (current-buffer))
;;           ;; Track the temporaries created by argument substitution in the
;;           ;; process itself, to get rid of the global state ASAP.
;;           (process-put process 'flycheck-temporaries flycheck-temporaries)
;;           (setq flycheck-temporaries nil)
;;           ;; Send the buffer to the process on standard input, if enabled
;;           (when (flycheck-checker-get checker 'standard-input)
;;             (save-excursion
;;               (save-restriction
;;                 (widen)
;;                 (goto-char (point-min))
;;                 (while (not (eobp))
;;                   (let ((from (point)))
;;                     (forward-char (min 50 (- (point-max) (point))))
;;                     (process-send-region process from (point))))
;;                 (process-send-eof process))))
;;           ;; Return the process
;;           process)
;;       (error
;;        ;; In case of error, clean up our resources, and report the error back to
;;        ;; Flycheck
;;        (flycheck-safe-delete-temporaries)
;;        (when process
;;          ;; No need to explicitly delete the temporary files of the process,
;;          ;; because deleting runs the sentinel, which will delete them anyway.
;;          (delete-process process))
;;        (signal (car err) (cdr err))))))


;; turn on flychecking globally
;; (add-hook 'after-init-hook #'global-flycheck-mode)


;; disable jshint since we prefer eslint checking
;; (setq-default flycheck-disabled-checkers
;;   (append flycheck-disabled-checkers
;;     '(javascript-jshint)))


;; use eslint with web-mode for jsx files
;; NOTE: commented because of checking rjsx-mode
;; (flycheck-add-mode 'javascript-eslint 'js2-mode)
;; (setq-default flycheck-temp-prefix ".flycheck")


;; To install eslint for flycheck/linter please run:
;;
;; $> sudo npm install -g eslint


;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (setq flycheck-eslintrc "~/.eslint/.eslintrc")
;; (setq flycheck-eslint-rules-directories '("~/.eslint/"))

;; NOTE: commented because of checking rjsx-mode
;; (add-hook 'js2-mode-hook
;;           (defun my-js2-mode-setup ()
;;             (flycheck-mode t)
;;             (when (executable-find "eslint")
;;               (flycheck-select-checker 'javascript-eslint))))


;; Other aproach to the problem.
(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


;; neotree
;;
;; Don't quite use it at all.
;;
;; (require 'neotree)
;; (global-set-key [f8] 'neotree-toggle)


;; typescript & JSX
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))


;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)


;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'js2-mode-hook #'setup-tide-mode)


(require 'web-mode)


;; TSX
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))


;; JSX
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))


(use-package tide-mode
  :config
  (progn
    ;; configure javascript-tide checker to run after your default javascript checker:
    (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
    ;; configure jsx-tide checker to run after your default jsx checker:
    (flycheck-add-mode 'javascript-eslint 'web-mode)
    (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)
    ))
;; end / typescript


;; kotlin
(setq kotlin-tab-width 4)
;; end / kotlin


;; SYSTEM MACHINE :: Load system + machine dependent file
(if (file-exists-p system-machine-file)
    (progn
      (message "SYSTEM MACHINE FILE %s exists. It will be loaded." system-machine-file)
      (load system-machine-file)
      )
  (message "SYSTEM MACHINE FILE %s DOES NOT exists. Nothing to load." system-machine-file)
  )
;; END / SYSTEM


(load "~/.emacs.d/keys.el")


(provide 'init)
;;; init.el ends here
