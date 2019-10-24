
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Emacs tip of the day
;; https://www.emacswiki.org/emacs/TipOfTheDay
(require 'cl)
 (defun totd ()
  (interactive)
  (with-output-to-temp-buffer "*Tip of the day*"
    (let* ((commands (loop for s being the symbols
                           when (commandp s) collect s))
           (command (nth (random (length commands)) commands)))
      (princ
       (concat "Your tip for the day is:\n========================\n\n"
               (describe-function command)
               "\n\nInvoke with:\n\n"
               (with-temp-buffer
                 (where-is command t)
                 (buffer-string)))))))

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

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))


(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; (add-hook 'js-mode-hook #'smartparens-mode)

;; shortcut macro to type console.log
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

;; Require this so that the related variables are defined
(require 'smart-mode-line)

;; Create a hook to call after emacs loads
(defun my/sml-setup-hook ()
  "Enable sml after Emacs has loaded."
  (sml/setup))

(add-hook 'after-init-hook 'my/sml-setup-hook)


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

;; (require 'smartparens-config)

;; When the buffer looks like {|} and the cursor is at |, hitting
;; enter indents to the correct place
(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

;; (sp-with-modes '(csharp-mode js-mode awk-mode typescript-mode)
;;   (sp-local-pair "(" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
;;   (sp-local-pair "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
;;   (sp-local-pair "[" nil :post-handlers '((my-create-newline-and-enter-sexp "RET"))))


(eval-after-load 'flycheck
  '(setq flycheck-xml-parser 'flycheck-parse-xml-region))


(global-set-key (kbd "RET") 'newline-and-indent)

<<<<<<< HEAD
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized/")
;; (load-theme 'solarized t)
=======
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized/")
;;(load-theme 'solarized-dark t)
>>>>>>> 9fcaeca3192098d791ddc179e6261fd3c2f03721

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
 '(battery-mode-line-format " %p%%")
 '(blink-cursor-blinks 1)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (smart-mode-line-dark solarized-dark)))
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(desktop-save (quote if-exists))
 '(desktop-save-mode t)
 '(display-battery-mode t)
 '(electric-indent-mode nil)
 '(electric-layout-mode nil)
 '(electric-pair-mode nil)
 '(flycheck-global-modes t)
 '(frame-background-mode (quote dark))
 '(global-flycheck-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(package-selected-packages
   (quote
    (web-mode solarized-theme smartparens smart-mode-line-powerline-theme rust-playground js2-mode)))
 '(show-paren-style (quote mixed))
 '(size-indication-mode t)
 '(sml/battery-format " %p%%")
 '(sml/show-frame-identification nil)
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
 '(typescript-mode-hook (quote (smartparens-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



