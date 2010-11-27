(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(column-number-mode t))

(when window-system
  (menu-bar-mode 1)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:inherit nil :stipple nil :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 125 :width normal :family "DejaVu Sans Mono"))))))

;disable backup
(setq backup-inhibited t)
(setq make-backup-files nil)


;disable auto save
(setq auto-save-default nil)

; disable alt for meta
;(setq ns-alternate-modifier nil)
; meta = C-x C-m
;(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-z" 'execute-extended-command)
; set Cmd as Meta
;(setq mac-command-modifier 'meta)
; disable beep
(setq ring-bell-function 'ignore)

;;; Spaces and tabs in C code

(setq c-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))
(setq objc-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))
(setq c++-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))

;; Spaces and tabs...

(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)
(setq standard-indent 4)
(setq c-indent-level 4)
(setq tab-width 4)
(setq default-tab-width 4)

;(setq-default show-trailing-whitespace t)

;; Another library path
(add-to-list 'load-path "~/.emacs.d/")

;; mine

(global-set-key [?\s-0] 'nav)
(global-set-key [\s-left] 'previous-buffer)
(global-set-key [\s-right] 'next-buffer)
(global-set-key [M-s-˙] 'ns-do-hide-others)
(global-set-key [M-s-up] 'ff-find-other-file)

; lua-mode
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

; js2-mode
(autoload #'js2-mode "js2" "Start js-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))


(setq cc-other-file-alist
'(("\\.cpp$" (".hpp" ".h"))
("\\.h$" (".c" ".cpp" ".m"))
("\\.hpp$" (".cpp" ".c"))
("\\.m$" (".h"))
))

;; disable color crap
;(setq-default global-font-lock-mode nil)
;(global-font-lock-mode 0)

;; define and bind textmate-like next-line
(defun textmate-next-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen 
    (if (frame-parameter nil 'fullscreen)
      nil
      'fullboth))) 

(global-set-key (kbd "<M-RET>") 'mac-toggle-max-window)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;; Display ido results vertically, rather than horizontally
;(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
;(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property
         (match-beginning 0)
         (match-end 0)
         'face (list :background 
                     (match-string-no-properties 0)))))))
(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))

(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)

(autoload 'word-count-mode "word-count"
           "Minor mode to count words." t nil)
(global-set-key "\M-+" 'word-count-mode)

; (require 'color-theme-gruber-darker)
;(color-theme-gruber-darker)
; (color-theme-initialize)
; (color-theme-pok-wob)


(defun count-words (start end)
   "Print number of words in the region."
   (interactive "r")
   (save-excursion
     (save-restriction
       (narrow-to-region start end)
       (goto-char (point-min))
       (count-matches "\\sw+"))))

; SLIME

(add-to-list 'load-path "~/quicklisp/dists/quicklisp/software/slime-20101107-cvs/")  ; your SLIME directory
(setq inferior-lisp-program "/usr/local/bin/sbcl") ; your Lisp system
(require 'slime)
(slime-setup)
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;(require 'quack)
(load-file "~/.emacs.d/geiser/elisp/geiser.el")
(setq geiser-active-implementations '(racket))
(require 'paredit)
(require 'highlight-parentheses)

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

;(define-key ctl-x-4-map "t" 'toggle-window-split)
