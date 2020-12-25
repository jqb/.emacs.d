(add-to-list 'tramp-methods
                   '("yadm"
                     (tramp-login-program "/home/jqb/.local/bin/yadm")
                     (tramp-login-args (("enter")))
                     (tramp-login-env (("SHELL") ("/bin/sh")))
                     (tramp-remote-shell "/bin/sh")
                     (tramp-remote-shell-args ("-c"))))
