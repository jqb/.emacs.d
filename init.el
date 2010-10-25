(if (string-match "GTK+" (emacs-version))
    (load "~/.emacs.d/xemacs-only.el")
  (load "~/.emacs.d/console-emacs-only.el"))


(require 'tramp)
(setq tramp-default-method "ssh")


(setq x-select-enable-clipboard t)
(setq-default show-trailing-whitespace t)
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


(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


(set-face-bold-p 'font-lock-keyword-face t)
(set-face-italic-p 'font-lock-comment-face t)



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




;;; git support
;; standard git support
;; (load "/usr/share/doc/git-core/contrib/emacs/git.el")
;; (load "/usr/share/doc/git-core/contrib/emacs/git-blame.el")
;; (load "/usr/share/doc/git-core/contrib/emacs/vc-git.el")
;; (add-to-list 'vc-handled-backends 'GIT)

;; magit / egg
(load "~/.emacs.d/egg/egg.el")
(load "~/.emacs.d/egg/egg-grep.el")
(require 'egg)


;; ibuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)



;;; nxhtml-mode
;; (load  "/home/kuba/.emacs.d/nxhtml/autostart")



;; php mode
(load "~/.emacs.d/php-mode.el")
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))



;;; django-mode
(load "~/.emacs.d/django-mode.el")
(add-to-list 'auto-mode-alist '("\\.html\\'" . django-mode))



;; Smooth scrolling mode
(load "/home/kuba/.emacs.d/smooth-scrolling.el")



;; javascript mode
(load "~/.emacs.d/javascript.el")
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))



;; java mode fixxes
(c-set-offset 'arglist-intro 4)
(c-set-offset 'arglist-close 0)



;; devils's pie mode 
(add-to-list 'auto-mode-alist '("\\.ds\\'" . lisp-mode))



;; graphviz-mode
(load-file "~/.emacs.d/graphviz-dot-mode.el")



;; Org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)
(setq org-agenda-files (list "~/.org/"))
(setq org-cycle-include-plain-lists t)



;; JSP mode 
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . html-mode))



;; GSP mode 
(add-to-list 'auto-mode-alist '("\\.gsp\\'" . html-mode))



;; yas templates
;; (add-to-list 'load-path "/etc/emacs/site-start.d/plugins")
;; (require 'yasnippet-bundle)
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)     ;; not yasnippet-bundle
(require 'dropdown-list) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")



(load "~/.emacs.d/tools.el")



(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)


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



(load "~/.emacs.d/ack.el")
(require 'ack)



(load "~/.emacs.d/smex.el")
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update-and-run)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;Old M-x.



;; apache mode
(load "~/.emacs.d/apache-mode.el")
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))



;; GO programing language
(load "~/.emacs.d/go-mode.el")
(load "~/.emacs.d/go-mode-load.el")
(require 'go-mode-load)




;; project management
(load "/home/kuba/.emacs.d/mk-project/mk-project.el")
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


;; auto-complete-mode
(add-to-list 'load-path "~/.emacs.d/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)
ac-fuzzy-cursor-color
