(progn
  (unless noninteractive (message "LINUX: loading additional PATH..."))
  (setenv "PATH" (concat
                  (expand-file-name "~/.local/bin")
                  ":"
                  (expand-file-name "~/tools/bin")
                  ":/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:"
                  (getenv "PATH")))
  (setq exec-path (cons "/usr/local/bin" exec-path))
  (setq shell-file-name "bash")
  (setq shell-command-switch "-ic")
  )
