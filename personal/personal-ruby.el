;;(add-hook 'ruby-mode-hook 'ruby-electric-mode)
(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)

(eval-after-load 'company
  '(push 'company-robe company-backends))

;;(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)
(global-set-key "\t" 'company-complete-common)


(add-hook 'robe-mode-hook
          (lambda () (local-set-key (kbd "<C-return>") #'ruby-send-line)))

(add-to-list 'inf-ruby-implementations '("pry" . "pry"))
(setq inf-ruby-default-implementation "pry")
;; (setq inf-ruby-first-prompt-pattern "^\\[[0-9]+\\] pry\\((.*)\\)> *")
;; (setq inf-ruby-prompt-pattern "^\\[[0-9]+\\] pry\\((.*)\\)[>*\"'] *")
