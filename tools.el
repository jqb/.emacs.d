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
;; (global-set-key (kbd "C-x M-w M-h") 'html-tag-wrap-text)



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
;; (global-set-key (kbd "C-x M-w M-d") 'django-tag-wrap-text)



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
;; (global-set-key (kbd "C-x M-w M-f") 'wrap-text)


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


(setq ibuffer-saved-filter-groups
     (quote (("default"
              ("python" (mode . python-mode))
              ("html" (or
		       (mode . html-mode)
		       (mode . django-mode)))
              ("dired"  (mode . dired-mode))
              ("planner" (or
                          (name . "^\\*Calendar\\*$")
                          (name . "^diary$")
                          (name . "^org$")
                          (mode . muse-mode)))
              ("emacs" (or
                        (name . "^\\*scratch\\*$")
                        (name . "^\\*Messages\\*$")))
              ("emacs lisp" (or
		       (mode . emacs-lisp-mode)
                       ))
              ))))
(add-hook 'ibuffer-mode-hook
         (lambda ()
           (ibuffer-switch-to-saved-filter-groups "default")))


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
;; (global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line)


;; multi-occur additional feature
(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
   (dolist (buf (buffer-list))
     (with-current-buffer buf
       (if (eq mode major-mode)
           (add-to-list 'buffer-mode-matches buf))))
   buffer-mode-matches))


(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))))
;; (global-set-key (kbd "C-<f2>") 'multi-occur-in-this-mode)



;; ftp support for passive mode
(defvar ange-ftp-hosts-no-pasv '("localhost")
  "*List of hosts that do not need PASV (e.g. hosts within your firewall).
  Used by `ange-ftp-set-passive'.")     ; rephrased, added "*" // era

(defun ange-ftp-set-passive ()
  "Function to send a PASV command to hosts not named in the variable
  `ange-ft-hosts-no-pasv'. Intended to be called from the hook variable
  `ange-ftp-process-startup-hook'."     ; rephrased significantly // era
  (if (not (member host ange-ftp-hosts-no-pasv))
      (ange-ftp-raw-send-cmd proc "passive")))
(add-hook 'ange-ftp-process-startup-hook 'ange-ftp-set-passive)


;; ido extension
(defun ido-goto-symbol (&optional symbol-list)
  "Refresh imenu and jump to a place in the buffer using Ido."
  (interactive)
  (unless (featurep 'imenu)
    (require 'imenu nil t))
  (cond
   ((not symbol-list)
    (let ((ido-mode ido-mode)
          (ido-enable-flex-matching
           (if (boundp 'ido-enable-flex-matching)
               ido-enable-flex-matching t))
          name-and-pos symbol-names position)
      (unless ido-mode
        (ido-mode 1)
        (setq ido-enable-flex-matching t))
      (while (progn
               (imenu--cleanup)
               (setq imenu--index-alist nil)
               (ido-goto-symbol (imenu--make-index-alist))
               (setq selected-symbol
                     (ido-completing-read "Symbol? " symbol-names))
               (string= (car imenu--rescan-item) selected-symbol)))
      (unless (and (boundp 'mark-active) mark-active)
        (push-mark nil t nil))
      (setq position (cdr (assoc selected-symbol name-and-pos)))
      (cond
       ((overlayp position)
        (goto-char (overlay-start position)))
       (t
        (goto-char position)))))
   ((listp symbol-list)
    (dolist (symbol symbol-list)
      (let (name position)
        (cond
         ((and (listp symbol) (imenu--subalist-p symbol))
          (ido-goto-symbol symbol))
         ((listp symbol)
          (setq name (car symbol))
          (setq position (cdr symbol)))
         ((stringp symbol)
          (setq name symbol)
          (setq position
                (get-text-property 1 'org-imenu-marker symbol))))
        (unless (or (null position) (null name)
                    (string= (car imenu--rescan-item) name))
          (add-to-list 'symbol-names name)
          (add-to-list 'name-and-pos (cons name position))))))))


(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))


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


(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))
;; (global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

(provide 'tools)