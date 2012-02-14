;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; for xemacs:
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-echo-area-message nil)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "Ubuntu Mono"))))
 '(cursor ((t (:background "white")))))


;; ;; fullscreen stuff
(defun fullscreen (&optional f)
  (interactive)
  (set-frame-parameter f 'fullscreen
		       (if (frame-parameter f 'fullscreen) nil 'fullboth)))

(global-set-key [f11] 'fullscreen)
(add-to-list 'default-frame-alist '(alpha 90 90))
;; (add-hook 'after-make-frame-functions 'fullscreen)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; end of xemacs settings



;; FOR WINDOWS
(defun my-windows-custom-face ()
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "unknown" :family "Courier New"))))
   '(cursor ((t (:background "white")))))
  )
(if (fboundp 'w32-send-sys-command)
    (add-hook 'window-setup-hook 'my-windows-custom-face))
;; trick for full screen on windows
(if (fboundp 'w32-send-sys-command)
    (add-hook 'window-setup-hook (lambda () (w32-send-sys-command #xf030))))
