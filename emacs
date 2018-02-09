
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

(add-hook 'js-mode-hook #'smartparens-mode)

(fset 'jlog
   "console.log(\"")

(add-to-list 'load-path "~/.emacs.d/lisp/")
;; (load "emacs_comp_specific")

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When called repeatedly, append copy subsequent lines.
When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2017-07-08"
  (interactive)
  (if current-prefix-arg
      (progn
        (kill-ring-save (point-min) (point-max))
        (message "All visible buffer text copied"))
    (if (use-region-p)
        (progn
          (kill-ring-save (region-beginning) (region-end))
          (message "Active region copied"))
      (if (eq last-command this-command)
          (if (eobp)
              (progn (message "empty line at end of buffer." ))
            (progn
              (kill-append "\n" nil)
              (kill-append
               (buffer-substring-no-properties (line-beginning-position) (line-end-position))
               nil)
              (message "Line copy appended")
              (progn
                (end-of-line)
                (forward-char))))
        (if (eobp)
            (if (eq (char-before) 10 )
                (progn (message "empty line at end of buffer." ))
              (progn
                (kill-ring-save (line-beginning-position) (line-end-position))
                (end-of-line)
                (message "line copied")))
          (progn
            (kill-ring-save (line-beginning-position) (line-end-position))
            (end-of-line)
            (forward-char)
            (message "line copied")))))))


;; From Better Defaults:
;; https://github.com/technomancy/better-defaults/blob/master/better-defaults.el
(unless (fboundp 'helm-mode)
  (ido-mode t)
  (setq ido-enable-flex-matching t))

(menu-bar-mode 1)
;; (menu-bar-mode -1)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;;(when (fboundp 'scroll-bar-mode)
;;  (scroll-bar-mode -1))

(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR." t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace)
(setq-default save-place t)


;; Instead of the simple "kill-ring-save" be smarter
(global-set-key (kbd "M-w") 'xah-copy-line-or-region)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(require 'smartparens-config)

;; When the buffer looks like {|} and the cursor is at |, hitting
;; enter indents to the correct place
(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

(sp-with-modes '(csharp-mode js-mode awk-mode typescript-mode)
  (sp-local-pair "(" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  (sp-local-pair "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  (sp-local-pair "[" nil :post-handlers '((my-create-newline-and-enter-sexp "RET"))))


(eval-after-load 'flycheck
  '(setq flycheck-xml-parser 'flycheck-parse-xml-region))


(global-set-key (kbd "RET") 'newline-and-indent)

(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized/")
(load-theme 'solarized t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(allout-auto-activation "ask")
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(apropos-do-all t)
 '(blink-cursor-blinks 1)
 '(column-number-mode t)
 '(desktop-save (quote if-exists))
 '(desktop-save-mode t)
 '(electric-indent-mode nil)
 '(electric-layout-mode nil)
 '(electric-pair-mode nil)
 '(flycheck-global-modes t)
 '(frame-background-mode (quote dark))
 '(global-flycheck-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(load-prefer-newer t)
 '(mouse-yank-at-point t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (web-mode comment-tags ruby-electric smartparens tide)))
 '(recentf-mode t)
 '(require-final-newline t)
 '(save-interprogram-paste-before-kill t)
 '(show-paren-mode 1)
 '(show-paren-style (quote mixed))
 '(tramp-default-method-alist
   (quote
    ((nil "%" "smb")
     ("\\`\\(127\\.0\\.0\\.1\\|::1\\|BEAST\\|localhost6?\\)\\'" "\\`root\\'" "su")
     (nil "\\`\\(anonymous\\|ftp\\)\\'" "ftp")
     ("\\`ftp\\." nil "ftp"))))
 '(tramp-default-user-alist
   (quote
    (("\\`smb\\'" nil nil)
     ("\\`\\(?:fcp\\|krlogin\\|nc\\|r\\(?:cp\\|emcp\\|sh\\)\\|telnet\\)\\'" nil "merc")
     ("\\`\\(?:ksu\\|su\\(?:do\\)?\\)\\'" nil "root")
     ("\\`\\(?:socks\\|tunnel\\)\\'" nil "merc")
     ("\\`synce\\'" nil nil)
     (nil "192.168.1.10" "pi"))))
 '(typescript-indent-level 2)
 '(typescript-mode-hook (quote (smartparens-mode)))
 '(visible-bell t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray16" :foreground "gainsboro" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Menlo"))))
 '(cursor ((t (:background "red")))))
