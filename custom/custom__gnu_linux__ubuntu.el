(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file nil)
 '(bookmark-default-file "~/.emacs.d/bookmarks")
 '(column-number-mode t)
 '(elpy-rpc-python-command "python3")
 '(inhibit-startup-echo-area-message nil)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (php-mode go-mode flymake-lua lua-mode jinja2-mode ssh tide web-mode flycheck elpy rjsx-mode typescript-mode ox-gfm markdown-preview-eww markdown-preview-mode markdown-mode+ graphviz-dot-mode python-mode erlang nginx-mode markdown-mode yaml-mode magit-gh-pulls magit dockerfile-mode ag bookmark+ projectile popup)))
 '(safe-local-variable-values
   (quote
    ((eval set
           (make-local-variable
            (quote projectile-globally-ignored-directories))
           (append projectile-globally-ignored-directories ".penv")))))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))


;; Mono 240 is good for 4K display, but not for simple, regular monitor.
;; With the latter I'll go with ... 170
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 180 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
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


(provide 'custom)
;;; custom.el ends here
