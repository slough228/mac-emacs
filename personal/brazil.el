(defvar amz-brazil-var-cache-dir
  (expand-file-name ".brazil-var-cache" (getenv "HOME"))
  "The directory of the Brazil var cache.")

;; create the cache dir if it doesn't exist
(when (not (file-exists-p amz-brazil-var-cache-dir))
  (make-directory amz-brazil-var-cache-dir t))

(defun find-up (dir file)
  "Find the given file name by searching in the given dir, then its parent dir, etc.
   Return the full path to the file once found.  If not found, returns nil."
  (cond
   ((file-exists-p (expand-file-name file dir))
    (expand-file-name file dir))
   ((f-root-p dir)
    nil)
   (t
    (let ((parent-dir (file-name-directory (directory-file-name dir))))
      (find-up parent-dir file)))))

(defun amz-brazil-workspace-root (dir)
  "Given a directory in a workspace, find the workspace root.  We don't use brazil
   directly because it's too slow."
  (let* ((package-info-file (find-up dir "packageInfo"))
         (workspace-root (directory-file-name (file-name-directory package-info-file))))
    workspace-root))

(defun amz-brazil-package-root (dir)
  "Given a directory in a package, find the package root."
  (let* ((config-file (find-up dir "Config"))
         (package-root (directory-file-name (file-name-directory config-file))))
    package-root))

(defun amz-brazil-package-name (dir)
  "Given a directory in a package, find the package name."
  (file-name-base (amz-brazil-package-root dir)))

(defun amz-brazil-recipe-cache-hash (&rest rest)
  "Hash the arguments."
  (secure-hash 'md5 (prin1-to-string rest)))

(defun amz-brazil-path-get-cache-file (workspace package var)
  (let* ((file-name (amz-brazil-recipe-cache-hash workspace package var))
         (file-path (expand-file-name file-name amz-brazil-var-cache-dir)))
    file-path))

(defun get-string-from-file (file)
  "Return file's content."
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

(defun amz-brazil-path-no-cache (var dir)
  (let ((path (string-trim-right
               (shell-command-to-string
                (concat "cd " dir "&& brazil-path " var " 2>/dev/null")))))
    (if (string= path "") nil path)))

(defun amz-brazil-path (var dir &optional refresh-cache-p)
  "Expand var with brazil-path, loading from cache if available.  If refresh-cache-p
   is non-nil, then refresh the cache too."
  (let* ((package (amz-brazil-package-name dir))
         (workspace (amz-brazil-workspace-root dir))
         (cache-file (amz-brazil-path-get-cache-file workspace package var)))
    (if (and (not refresh-cache-p) (file-exists-p cache-file))
        (get-string-from-file cache-file)
      (let ((bp (amz-brazil-path-no-cache var dir)))
        (with-temp-buffer (insert bp) (write-file cache-file))
        bp))))

(defun amz-brazil-generate-go-path (graph dir &optional refresh-cache-p)
  "Generate a GOPATH for the current package."
  (let* ((bp (amz-brazil-path (concat graph ".gopath") dir refresh-cache-p))
         (bp-stripped (replace-regexp-in-string "\{.*?\}" "" bp))
         (bp-with-pkg (concat (amz-brazil-package-root dir) ":" bp-stripped)))
    bp-with-pkg))

(defun amz-brazil-set-go-path (&optional refresh-cache-p)
  (interactive)
  (setenv "GOPATH"
          (amz-brazil-generate-go-path
           "testrun"
           (directory-file-name (file-name-directory buffer-file-name))
           refresh-cache-p)))
