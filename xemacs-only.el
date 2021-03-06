(scroll-bar-mode -1)
(tool-bar-mode -1)


;; FOR WINDOWS
;; trick for full screen on windows
(if (fboundp 'w32-send-sys-command)
    (add-hook 'window-setup-hook (lambda () (w32-send-sys-command #xf030))))


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
