(project-def "mgr-harry"
      '((basedir          "/home/kuba/Dokumenty/projects/multilang/mgr-harry/")
        (src-patterns     ("*.py" "*.html"))
        (ignore-patterns  ("*.pyc" "*~"))
        (tags-file        "/home/kuba/Dokumenty/projects/multilang/mgr-harry/.pr/TAGS")
        (file-list-cache  "/home/kuba/Dokumenty/projects/multilang/mgr-harry/.pr/files")
        (open-files-cache "/home/kuba/Dokumenty/projects/multilang/mgr-harry/.pr/open-files")
        (vcs              git)
        (ack-args         "--python --html")
        (startup-hook     mgr-harry-startup)
        (shutdown-hook    nil)))
(defun mgr-harry-startup ()
  (ibuffer))



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



(project-def "django-timetable"
      '((basedir          "/home/kuba/Dokumenty/projects/multilang/django/django-timetable")
        (src-patterns     ("*.py" "*.html" "*.rst"))
        (ignore-patterns  ("*.pyc" "*~"))
        (tags-file        "/home/kuba/Dokumenty/projects/multilang/django/django-timetable/.pr/TAGS")
        (file-list-cache  "/home/kuba/Dokumenty/projects/multilang/django/django-timetable/.pr/files")
        (open-files-cache "/home/kuba/Dokumenty/projects/multilang/django/django-timetable/.pr/open-files")
        (vcs              git)
        (ack-args         "--python --html")
        (startup-hook     django-timetable-startup)
        (shutdown-hook    nil)))
(defun django-timetable-startup ()
  (ibuffer))



(project-def "django-sandbox"
      '((basedir          "/home/kuba/Dokumenty/projects/multilang/sandbox_workspace/sandbox")
        (src-patterns     ("*.py" "*.html" "*.rst"))
        (ignore-patterns  ("*.pyc" "*~"))
        (tags-file        "/home/kuba/Dokumenty/projects/multilang/sandbox_workspace/sandbox/.pr/TAGS")
        (file-list-cache  "/home/kuba/Dokumenty/projects/multilang/sandbox_workspace/sandbox/.pr/files")
        (open-files-cache "/home/kuba/Dokumenty/projects/multilang/sandbox_workspace/sandbox/.pr/open-files")
        (vcs              git)
        (ack-args         "--python --html")
        (startup-hook     django-sandbox-startup)
        (shutdown-hook    nil)))
(defun django-sandbox-startup ()
  (ibuffer))
