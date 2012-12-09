(require 'desktop)


(defvar my-desktop-session-dir
  (concat (getenv "HOME") "/.emacs.d/desktop-sessions/")
  "*Directory to save desktop sessions in")


(defvar my-desktop-session-name-hist nil
  "Desktop session name history")


(defvar my-desktop-current-session-name nil
  "Current desktop session name")


(defun my-desktop-save (&optional name)
  "Save desktop with a name."
  (interactive)
  (unless name
    (setq name my-desktop-current-session-name))
  (unless name
    (setq name (my-desktop-get-session-name "Save session as: ")))
  (make-directory (concat my-desktop-session-dir name) t)
  (setq my-desktop-current-session-name name)
  (desktop-save (concat my-desktop-session-dir name) t)
  (message (concat "Session \"" my-desktop-current-session-name "\"" " saved.")))


(defun my-desktop-read (&optional name)
  "Read desktop with a name."
  (interactive)
  (unless name
    (setq name (my-desktop-get-session-name "Load session: ")))
  (if my-desktop-current-session-name
      (my-desktop-save my-desktop-current-session-name))
  (setq my-desktop-current-session-name name)
  (desktop-clear)
  (desktop-read (concat my-desktop-session-dir name))
  (ibuffer))


(defun my-desktop-clear (&optional name)
  (interactive)
  (if my-desktop-current-session-name
      (my-desktop-save my-desktop-current-session-name))
  (if my-desktop-current-session-name
      (setq my-desktop-current-session-name nil))
  (desktop-clear))


(defun my-desktop-show-current-session-name ()
  (interactive)
  (message (concat "Current session is: \"" my-desktop-current-session-name "\"")))


(defun my-desktop-get-session-name (prompt)
  (completing-read prompt (and (file-exists-p my-desktop-session-dir)
                               (directory-files my-desktop-session-dir))
                   nil nil nil my-desktop-session-name-hist))


(global-set-key (kbd "C-c t s") 'my-desktop-save)
(global-set-key (kbd "C-c t r") 'my-desktop-read)
(global-set-key (kbd "C-c t n") 'my-desktop-clear)
(global-set-key (kbd "C-c t c") 'my-desktop-show-current-session-name)


(global-set-key (kbd "C-c t 1") (lambda () (interactive) (my-desktop-read "1")))
(global-set-key (kbd "C-c t 2") (lambda () (interactive) (my-desktop-read "2")))
(global-set-key (kbd "C-c t 3") (lambda () (interactive) (my-desktop-read "3")))
(global-set-key (kbd "C-c t 4") (lambda () (interactive) (my-desktop-read "4")))
(global-set-key (kbd "C-c t 5") (lambda () (interactive) (my-desktop-read "5")))

