(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(column-number-mode t)
 '(inhibit-startup-echo-area-message nil)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (ox-gfm markdown-preview-eww markdown-preview-mode markdown-mode+ graphviz-dot-mode python-mode erlang nginx-mode markdown-mode yaml-mode magit-gh-pulls magit dockerfile-mode ag bookmark+ projectile popup)))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 200 :width normal :foundry "unknown" :family "Ubuntu Mono"))))
 '(cursor ((t (:background "white"))))
 '(mmm-default-submode-face ((t (:background "gray10")))))


(defun my-windows-custom-face ()
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "unknown" :family "Courier New"))))
   '(cursor ((t (:background "white")))))
  )
(if (fboundp 'w32-send-sys-command)
    (add-hook 'window-setup-hook 'my-windows-custom-face))


;; FOR MAC
(if (eq system-type 'darwin)
  (progn
    (add-hook 'window-setup-hook 'toggle-frame-fullscreen)
    (custom-set-faces
     '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 190 :width normal :foundry "unknown" :family "Courier New"))))
     '(cursor ((t (:background "white")))))
  )
)
