(add-hook 'ruby-mode-hook
           (lambda()
             (add-hook 'local-write-file-hooks
                       '(lambda()
                          (save-excursion
                            (untabify (point-min) (point-max))
                            (delete-trailing-whitespace)
                            )))
;;             (define-key ruby-mode-map "C-m" 'newline-and-indent) ;Not sure if this line is 100% right but it works!
             (require 'ruby-electric)
             (ruby-electric-mode t)
             ))

(setq p4-use-p4config-exclusively t)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "emacs_comp_specific")

(put 'narrow-to-region 'disabled nil)

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(frame-background-mode (quote dark))
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(show-paren-mode t)
 '(show-paren-style (quote mixed)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray16" :foreground "gainsboro" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Menlo")))))
(put 'downcase-region 'disabled nil)
