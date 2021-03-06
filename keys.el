;; GLOBAL KEY BINDINGS


(global-set-key [f12] 'menu-bar-mode)


(global-set-key (kbd "C-c n") 'delete-trailing-whitespace)

;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cc" 'org-capture)
;; (global-set-key "\C-cb" 'org-iswitchb)

;; ibuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<C-M-return>") 'ns-toggle-fullscreen)


;; (global-set-key (kbd "M-k") 'previous-line)
;; (global-set-key (kbd "M-,") 'forward-line)
;; (global-set-key (kbd "M-m") 'backward-char)
;; (global-set-key (kbd "M-l") 'forward-char)
;; (global-set-key (kbd "M-n") 'backward-word)

;; (global-set-key (kbd "M-o") 'forward-word)
;; (global-set-key (kbd "M-p") 'forward-word)

;; (global-set-key (kbd "M-b") 'move-beginning-of-line)
;; (global-set-key (kbd "M-0") 'move-end-of-line)

;; (global-set-key (kbd "M-f") 'delete-char)
;; (global-set-key (kbd "M-d") 'backward-delete-char-untabify)

;; ;; use hippie-expand instead of dabbrev
;; ;; (global-set-key (kbd "M-/") 'hippie-expand)

;; (global-set-key (kbd "M-]") 'forward-paragraph)
;; (global-set-key (kbd "M-[") 'backward-paragraph)

;; (global-set-key (kbd "M-e") 'backward-kill-word)
;; (global-set-key (kbd "M-r") 'kill-word)
;; (global-set-key (kbd "M-4") 'kill-line)

(global-set-key (kbd "C-M-b") 'backward-word)
(global-set-key (kbd "C-M-f") 'forward-word)

(global-set-key (kbd "C-M-n") 'forward-paragraph)
(global-set-key (kbd "C-M-p") 'backward-paragraph)

(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)


(global-set-key (kbd "C-{") (kbd "C-u - 1 0 S-M-<up>"))
(global-set-key (kbd "C-:") (kbd "C-u - 1 0 S-M-<down>"))

(global-set-key (kbd "C-x p") (lambda ()
                                (interactive)
                                (other-window -1))) ;; back one


(provide 'keys)
;;; keys.el ends here
