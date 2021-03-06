(defvar myPackagesA
  '(sr-speedbar
    elpy
    py-autopep8
    org-beautify-theme
    org-bullets
    yafolding
    sphinx-doc
    spacemacs-theme
    powerline
    color-theme-sanityinc-tomorrow
    paredit
    ruby-electric
    robe
    iedit
    flymd
    treemacs
    ox-gfm
    company-go
    all-the-icons
    all-the-icons-dired
    evil-numbers
    elm-mode
    flycheck-elm
    eclim
    company-emacs-eclim
    org-journal
    elm-mode
    ))

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackagesA)


(setq backup-directory-alist `(("." . "~/.saves")))

(require 'prelude-helm)
(require 'prelude-company)
(require 'prelude-helm-everywhere)
;;(require 'prelude-go)
;;(require 'prelude-c)
(require 'prelude-python)
(require 'prelude-shell)
(require 'prelude-web)
;;(require 'prelude-js)
;;(require 'prelude-ruby)
(require 'prelude-macos)
;;(require 'prelude-clojure)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

(set-default-coding-systems 'utf-8)


;; make tab complete files
(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)

;; Mouse zoom
(global-set-key [C-wheel-up]  'text-scale-increase)
(global-set-key  [C-wheel-down] 'text-scale-decrease)


;; theme
(disable-theme 'zenburn)
(load-theme 'sanityinc-tomorrow-night)

;; all-the-icons
(require 'all-the-icons)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; powerline
(require 'powerline)
(powerline-default-theme)

;; Typography
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 150
                    :weight 'normal
                    :width 'normal)

;; Markdown
(setq markdown-command "/usr/local/bin/pandoc")
(require 'flymd)

;; Large Files
(defun my-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (fundamental-mode)))

(add-hook 'find-file-hook 'my-find-file-check-make-large-file-read-only-hook)

(prelude-swap-meta-and-super)

;; no scroll bar
(scroll-bar-mode 0)

;; backups
(setq backup-directory-alist '(("." . "~/saves")))

;; Emacs-org-issues
;;(add-to-list 'load-path "~/local-emacs-packages/Emacs-org-issues-mode/src")

;;(require 'org-issues-mode)
;;(org-issues-update/monitor-issues) ;; Sets up a timer to automatically keep your local Issues up-to-date


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; this is a cool function.
(defun arrayify (start end quote)
  "Turn strings on newlines into a quoted, comma-separated one-liner."
  (interactive "r\nMQuote: ")
  (let ((insertion (mapconcat (lambda (x)(format "%s%s%s" quote x quote))
                              (split-string (buffer-substring start end)) ",")))
    (delete-region start end)
    (insert insertion)))
