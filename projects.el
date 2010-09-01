(project-def "django-harry"
      '((basedir          "/home/kuba/Dokumenty/projects/multilang/django/django-harry/")
        (src-patterns     ("*.py" "*.html"))
        (ignore-patterns  ("*.pyc" "*~"))
        (tags-file        "/home/kuba/Dokumenty/projects/multilang/django/django-harry/.pr/TAGS")
        (file-list-cache  "/home/kuba/Dokumenty/projects/multilang/django/django-harry/.pr/files")
        (open-files-cache "/home/kuba/Dokumenty/projects/multilang/django/django-harry/.pr/open-files")
        (vcs              git)
        (ack-args         "--python --html")
        (startup-hook     django-harry-startup)
        (shutdown-hook    nil)))
(defun django-harry-startup ()
  (ibuffer))



(project-def "django-data-render"
      '((basedir          "/home/kuba/Dokumenty/projects/multilang/django/django-data-render/project")
        (src-patterns     ("*.py" "*.html" "*.rst"))
        (ignore-patterns  ("*.pyc" "*~"))
        (tags-file        "/home/kuba/Dokumenty/projects/multilang/django/django-data-render/.pr/TAGS")
        (file-list-cache  "/home/kuba/Dokumenty/projects/multilang/django/django-data-render/.pr/files")
        (open-files-cache "/home/kuba/Dokumenty/projects/multilang/django/django-data-render/.pr/open-files")
        (vcs              git)
        (ack-args         "--python --html")
        (startup-hook     django-data-render-startup)
        (shutdown-hook    nil)))
(defun django-data-render-startup ()
  (ibuffer))



(project-def "django-settings"
      '((basedir          "/home/kuba/Dokumenty/projects/multilang/django/django-settings/project")
        (src-patterns     ("*.py" "*.html"))
        (ignore-patterns  ("*.pyc" "*~"))
        (tags-file        "/home/kuba/Dokumenty/projects/multilang/django/django-settings/.pr/TAGS")
        (file-list-cache  "/home/kuba/Dokumenty/projects/multilang/django/django-settings/.pr/files")
        (open-files-cache "/home/kuba/Dokumenty/projects/multilang/django/django-settings/.pr/open-files")
        (vcs              git)
        (ack-args         "--python --html")
        (startup-hook     django-settings-startup)
        (shutdown-hook    nil)))
(defun django-settings-startup ()
  (ibuffer))
