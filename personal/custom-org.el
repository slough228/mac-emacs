;; See https://zzamboni.org/post/beautifying-org-mode-in-emacs/ for source

;; (setq org-hide-emphasis-markers t)

;; (font-lock-add-keywords 'org-mode
;;                         '(("^ *\\([-]\\) "
;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; (let* ((variable-tuple
;;         (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;;               ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
;;               ((x-list-fonts "Verdana")         '(:font "Verdana"))
;;               ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;               (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
;;        (base-font-color     (face-foreground 'default nil 'default))
;;        (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

;;   (custom-theme-set-faces
;;    'user
;;    `(org-level-8 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-7 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-6 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-5 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
;;    `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
;;    `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
;;    `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
;;    `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

;; (custom-theme-set-faces
;;  'user
;;  '(variable-pitch ((t (:family "Source Sans Pro" :height 180 :weight light))))
;;  '(fixed-pitch ((t ( :family "Inconsolata" :slant normal :weight normal :height 1.0 :width normal)))))

;; (add-hook 'org-mode-hook 'variable-pitch-mode)
;; (add-hook 'org-mode-hook 'visual-line-mode)

;; (custom-theme-set-faces
;;  'user
;;  '(org-block                 ((t (:inherit fixed-pitch))))
;;  '(org-document-info         ((t (:foreground "dark orange"))))
;;  '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
;;  '(org-link                  ((t (:foreground "royal blue" :underline t))))
;;  '(org-meta-line             ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-property-value        ((t (:inherit fixed-pitch))) t)
;;  '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
;;  '(org-verbatim              ((t (:inherit (shadow fixed-pitch))))))
(add-hook 'org-mode-hook 'mixed-pitch-mode)
(add-hook 'org-mode-hook 'org-bullets-mode)


(org-babel-do-load-languages
 'org-babel-load-languages '((shell . t)))

;; (setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "<img draggable="false" class="emoji" alt="✔" src="https://s0.wp.com/wp-content/mu-plugins/wpcom-smileys/twemoji/2/svg/2714.svg" scale="0"> DONE(d)")
;;                           (sequence "⚑ WAITING(w)" "|")
;;                           (sequence "|" "✘ CANCELED(c)")))

(setq org-todo-keywords
      '((sequence "☛ TODO(t)" "⚑ WAITING(w@/!)" "|" "✔ DONE(d!)" "✘ CANCELED(c@)")))
;; #+TODO: TODO(t) WAIT(w@/!) | DONE(d!) CANCELED(c@)

;; To save the clock history across Emacs sessions, use
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
