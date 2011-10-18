;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; for xemacs:
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-echo-area-message nil)
 '(inhibit-startup-screen t)
 '(tooltip-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 65 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(cursor ((t (:background "white")))))


;; ;; fullscreen stuff
(defun fullscreen (&optional f)
  (interactive)
  (set-frame-parameter f 'fullscreen
		       (if (frame-parameter f 'fullscreen) nil 'fullboth)))

(global-set-key [f11] 'fullscreen)
(add-hook 'after-make-frame-functions 'fullscreen)
(add-to-list 'default-frame-alist '(alpha 90 90))


;; work's only for xemacs:
;; (tabbar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(global-hl-line-mode -1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; end of xemacs settings
