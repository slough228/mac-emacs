;; my own python roll
(elpy-enable)

;; (setq elpy-rpc-python-command "python3")

;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;             "jupyter")

;; current hack is forcing ipython to 4.2.1.  it is the ONLY solution for multiline edits in python interpreter buffer
;; (setq python-shell-interpreter "ipython")
;; (setq python-shell-interpreter-args "")
(setq python-shell-interpreter "ipython" python-shell-interpreter-args "--simple-prompt -i")
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "jupyter")


(require 'py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
