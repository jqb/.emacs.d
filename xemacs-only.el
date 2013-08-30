;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; for xemacs:
(custom-set-variables
 '(column-number-mode t)
 '(inhibit-startup-echo-area-message nil)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "unknown" :family "Ubuntu Mono"))))
 '(cursor ((t (:background "white"))))
 '(mmm-default-submode-face ((t (:background "gray10")))))
(add-to-list 'default-frame-alist '(alpha 90 90))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; end of xemacs settings


;; FOR WINDOWS
;; trick for full screen on windows
(if (fboundp 'w32-send-sys-command)
    (add-hook 'window-setup-hook (lambda () (w32-send-sys-command #xf030))))

(defun my-windows-custom-face ()
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
   '(cursor ((t (:background "white")))))
  )
(if (fboundp 'w32-send-sys-command)
    (add-hook 'window-setup-hook 'my-windows-custom-face))


;; FOR MAC
(if (eq system-type 'darwin)
  (progn
    (fset 'kmacro-maximize-screen
      (lambda (&optional arg)
       "Keyboard macro."
       (interactive "p") (kmacro-exec-ring-item (quote ([C-M-return] 0 "%d")) arg)))
    (add-hook 'window-setup-hook 'kmacro-maximize-screen)
    (custom-set-faces
     '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "unknown" :family "Courier"))))
     '(cursor ((t (:background "white")))))
  )
)


;; FOR Ubuntu
(if (eq system-type 'gnu/linux)
    (progn
      (defun maximize-screen (&optional f)
        (interactive)
        (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                               '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
        (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                               '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
      (defun full-screen (&optional f)
        (interactive)
        (set-frame-parameter f 'fullscreen (if (frame-parameter f 'fullscreen) nil 'fullboth)))
      (global-set-key [f11] 'maximize-screen)
      (global-set-key [C-f11] 'full-screen)
      (maximize-screen)))
