(require 'eclim)
(setq eclimd-autostart t)

(defun my-java-mode-hook ()
  (eclim-mode t))

(add-hook 'java-mode-hook 'my-java-mode-hook)

(custom-set-variables
 '(eclim-eclipse-dirs '("~/eclipse/java-2019-12/Eclipse.app"))
 '(eclim-executable "/Users/samlough/.p2/pool/plugins/org.eclim_2.8.0/bin/eclim"))

(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(setq company-emacs-eclim-ignore-case t)
