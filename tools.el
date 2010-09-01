;; my own functions
(defun html-tag-wrap-text (b e txt)
  "simple wrapper"
  (interactive "r\nMEnter html tag to wrap with: ")
  (save-restriction
    (narrow-to-region b e)
    (goto-char (point-min))
    (insert "<")(insert txt)(insert ">")
    (goto-char (point-max))
    (insert "</")(insert txt)(insert ">")
    (goto-char (point-min)))
  )
(global-set-key (kbd "C-x M-w M-h") 'html-tag-wrap-text)



(defun django-tag-wrap-text (b e txt)
  "simple wrapper"
  (interactive "r\nMEnter django tag to wrap with: ")
  (save-restriction
    (narrow-to-region b e)
    (goto-char (point-min))
    (insert "{% ")(insert txt)(insert " \"")
    (goto-char (point-max))
    (insert "\" %}")
    (goto-char (point-min)))
  )
(global-set-key (kbd "C-x M-w M-d") 'django-tag-wrap-text)



(defun wrap-text (b e txt)
  "simple wrapper"
  (interactive "r\nMEnter text to wrap with: ")
  (save-restriction
    (narrow-to-region b e)
    (goto-char (point-min))
    (insert txt)(insert "(")
    (goto-char (point-max))
    (insert ")")(goto-char (point-min)))
  )
(global-set-key (kbd "C-x M-w M-f") 'wrap-text)


(defun quote-wrap-text (b e txt)
  "simple wrapper"
  (interactive "r\nMEnter quote to wrap with: ")
  (save-restriction
    (narrow-to-region b e)
    (goto-char (point-min))
    (insert txt)
    (goto-char (point-max))
    (insert txt)(goto-char (point-min)))
  )
(global-set-key (kbd "C-x M-w M-q") 'quote-wrap-text)


;; by Nikolaj Schumacher, 2008-10-20. Released under GPL.
(defun semnav-up (arg)
  (interactive "p")
  (when (nth 3 (syntax-ppss))
    (if (> arg 0)
        (progn
          (skip-syntax-forward "^\"")
          (goto-char (1+ (point)))
          (decf arg))
      (skip-syntax-backward "^\"")
      (goto-char (1- (point)))
      (incf arg)))
  (up-list arg))


;; by Nikolaj Schumacher, 2008-10-20. Released under GPL.
(defun extend-selection (arg &optional incremental)
  "Select the current word. Subsequent calls expands the selection to larger semantic unit."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     (or (and transient-mark-mode mark-active)
                         (eq last-command this-command))))
  (if incremental
      (progn
        (semnav-up (- arg))
        (forward-sexp)
        (mark-sexp -1))
    (if (> arg 1)
        (extend-selection (1- arg) t)
      (if (looking-at "\\=\\(\\s_\\|\\sw\\)*\\_>")
          (goto-char (match-end 0))
        (unless (memq (char-before) '(?\) ?\"))
          (forward-sexp)))
      (mark-sexp -1))))
(global-set-key (kbd "M-&") 'extend-selection)


(defun select-text-in-quote ()
"Select text between the nearest left and right delimiters.
Delimiters are paired characters: ()[]<>«»“”‘’「」, including \"\"."
 (interactive)
 (let (b1 b2)
   (skip-chars-backward "^<>(“{[「«\"‘'")
   (setq b1 (point))
   (skip-chars-forward "^<>)”}]」»\"’'")
   (setq b2 (point))
   (set-mark b1)
   )
 )
(global-set-key (kbd "M-*") 'select-text-in-quote)


;; (defun da-match-paren (arg)
;;   "Go to the matching paren if on a paren."
;;   (interactive "p")
;;   (cond ((and mark-active (looking-at "\\s\(")) (forward-list 1))
;; 	((and mark-active (looking-back "\\s\)")) (backward-list 1))
;; 	((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;; 	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;; 	))
;; (global-set-key (kbd "M-[") ‘da-match-paren)


;; rename buffer and file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME." (interactive "sNew name: ")
  (let ((name (buffer-name))
	(filename (buffer-file-name)))
    (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
	  (message "A buffer named '%s' already exists!" new-name)
	(progn  (rename-file name new-name 1)  
		(rename-buffer new-name)
		(set-visited-file-name new-name)
		(set-buffer-modified-p nil)))))) ;;


;; (setq ibuffer-saved-filter-groups
;;      (quote (("default"
;;               ("python" (mode . python-mode))
;;               ("dired"  (mode . dired-mode))
;;               ("planner" (or
;;                           (name . "^\\*Calendar\\*$")
;;                           (name . "^diary$")
;;                           (name . "^org$")
;;                           (mode . muse-mode)))
;;               ("emacs" (or
;;                         (name . "^\\*scratch\\*$")
;;                         (name . "^\\*Messages\\*$")))
;;               ("gnus" (or
;;                        (mode . message-mode)
;;                        (mode . bbdb-mode)
;;                        (mode . mail-mode)
;;                        (mode . gnus-group-mode)
;;                        (mode . gnus-summary-mode)
;;                        (mode . gnus-article-mode)
;;                        (name . "^\\.bbdb$")
;;                        (name . "^\\.newsrc-dribble")))))))
;; (add-hook 'ibuffer-mode-hook
;;          (lambda ()
;;            (ibuffer-switch-to-saved-filter-groups "default")))


(global-set-key (kbd "C-c t t") 'toggle-truncate-lines)
(global-set-key (kbd "S-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-M-<down>") 'shrink-window)
(global-set-key (kbd "S-M-<up>") 'enlarge-window)



;; switching between windows
(global-set-key (kbd "C-c <C-right>") 'windmove-right)
(global-set-key (kbd "C-c <C-left>") 'windmove-left)
(global-set-key (kbd "C-c <C-up>") 'windmove-up)
(global-set-key (kbd "C-c <C-down>") 'windmove-down)

(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)



;; tags creation
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (eshell-command 
   (format "find %s -type f | egrep -v '(.svn)|(.git)' | etags - -l auto" dir-name)))



(defun create-tags-python (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (eshell-command 
   (format "find %s -type f | egrep -v '(.svn)|(.git)' | etags - -l python" dir-name)))



;; Comment and uncomment region or line  (C-/)
(defun comment-or-uncomment-region-or-line ()
  (interactive)
  (if (not mark-active)
      (comment-or-uncomment-region
        (line-beginning-position) (line-end-position))
      (if (< (point) (mark))
          (comment-or-uncomment-region (point) (mark))
        (comment-or-uncomment-region (mark) (point)))))
(global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line)



;; stuff
(load  "/home/kuba/.emacs.d/multi-term.el")
(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)

(setq multi-term-program "/bin/bash")

;; only needed if you use autopair
;; (add-hook 'term-mode-hook
;; 	  '(lambda () (setq autopair-dont-activate t)))

(global-set-key (kbd "C-c c") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term) ;; create a new one

(add-hook 'term-mode-hook
	  (lambda ()
	    (define-key term-raw-map (kbd "C-<left>") 'term-send-backward-word)
	    (define-key term-raw-map (kbd "C-<right>") 'term-send-forward-word)
	    (define-key term-raw-map (kbd "C-r") 'term-send-reverse-search-history)
	    (define-key term-raw-map (kbd "<C-backspace>") 'term-send-backward-kill-word)
	    ))

;; (custom-set-variables
;;  '(term-default-bg-color "#000000") ;; background color (black)
;;  '(term-default-fg-color "#dddd00")) ;; foreground color (yellow)
 


;; ;; enable cua and transient mark modes in term-line-mode
;; (defadvice term-line-mode (after term-line-mode-fixes ())
;;   (set (make-local-variable 'cua-mode) t)
;;   (set (make-local-variable 'transient-mark-mode) t))
;; (ad-activate 'term-line-mode)
;; ;; disable cua and transient mark modes in term-char-mode
;; (defadvice term-char-mode (after term-char-mode-fixes ())
;;   (set (make-local-variable 'cua-mode) nil)
;;   (set (make-local-variable 'transient-mark-mode) nil))
;; (ad-activate 'term-char-mode)

;; (global-set-key (kbd "C-c C-j") 'term-line-mode)
;; (global-set-key (kbd "C-c C-k") 'term-char-mode)
