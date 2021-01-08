;; Loaded only on windows
(progn
  (setenv "PATH"
          (concat
           "C:/Users/jqbj/scoop/shims"
           ";"
           (getenv "PATH")
           )
          )
  (setq visible-bell 1)
  )
;; END
