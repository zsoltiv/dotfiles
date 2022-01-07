(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(initial-buffer-choice t)
 '(initial-scratch-message "")
 '(package-selected-packages
   '(yasnippet ace-window dired-x magit company lsp-mode gruvbox-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Set up packages
(defmacro install-package (package)
  "Installs a package if it isn't installed already."
  (interactive)

  `(unless (package-installed-p ,package)
     (package-install ,package)))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(install-package 'evil)
(install-package 'lsp-mode)
(install-package 'company)
(install-package 'magit)
(install-package 'ace-window)
(install-package 'yasnippet)

(require 'evil)
(require 'lsp-mode)
(require 'autoinsert)
(add-to-list 'load-path "/usr/share/emacs/site-lisp/go-mode")
(require 'go-mode)

(require 'cl)


;; functions and macros
(defun find-user-init-file ()
  "Opens user-init-file"
  (interactive)

  (find-file user-init-file))

(defun display-relative-line-numbers-mode ()
  "Enables display-line-numbers-mode and set display-line-numbers to 'relative"
  (interactive)

  (display-line-numbers-mode)
  (setq display-line-numbers 'relative))

(defmacro run-every-n-minutes (n exp)
  "Evaluate EXP every N minutes"

  `(run-with-timer 0 (* ,n 60) ,exp))

(defcustom info-window-regex "\\*\\([Hh]elp|Man|Apropos\\)\\*"
  "Regular expression for Help, Man, Apropos buffers"
  :type '(string)
  :group 'my-custom)
(defun display-buffer-reuse-info (buffer alist)
  (let ((window (car (remove-if-not
		      (lambda (w)
			(string-match info-window-regex
				      (buffer-name (window-buffer w))))
		      (window-list)))))
    (if (and window (window-live-p window))
	(window--display-buffer buffer window 'reuse alist))))

(defun left-side-dired ()
  "Open dired on the left with buffer name *Dired*"
  (interactive)
  (let ((dired-left-name "*Dired-Left*"))
    (if (not (get-buffer-window dired-left-name))
      (progn
	(let ((dir (if (eq (vc-root-dir) nil)
		       (dired-noselect default-directory)
		     (dired-noselect (vc-root-dir)))))
	  (display-buffer-in-side-window
	   dir `((side . left)
		 (slot . 0)
		 (window-width . 0.2)
	         (window-parameters . ((no-other-window . t)
				       (no-delete-other-windows . t)
				       (mode-line-format . (" " "%b"))))))
	 (with-current-buffer dir
	   (rename-buffer dired-left-name))))
      (select-window (get-buffer-window dired-left-name)))))

(defun find-notes-file ()
  (interactive)
  (find-file "~/notes.org"))

(defun open-in-program ()
  "Opens BUFFER in a program based on its file extension"
  (interactive)
  (let* ((extension (file-name-extension (buffer-file-name (current-buffer))))
	 (command (cond ((string= extension "html") "chromium"))))
    (start-process "Emacs external process" nil command (buffer-file-name (current-buffer)))))

(defmacro insert-line (&rest args)
  (when args
    `(progn
       (insert  ,@args)
       (newline))))

(defun autoinsert-yas-expand ()
  "Replace text in template"
  (yas-expand-snippet (buffer-string) (point-min) (point-max)))

;; aesthetic settings
(set-face-attribute 'default nil
		    :font "undefined medium"
		    :height 80)
(setq default-frame-alist '((font . "undefined medium")
                            (font . "JackeyFont")))
(load-theme 'gruvbox t)

;; rest of the config
(evil-mode 1) ; use evil mode
(yas-global-mode 1) ; use yas
; relative line numbers
(add-hook 'text-mode-hook 'display-relative-line-numbers-mode)
(add-hook 'prog-mode-hook 'display-relative-line-numbers-mode)
; lsp
(setq lsp-clangd-binary-path "/usr/lib/llvm/12/bin/clangd")
(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-ui-sideline-enable t)
(setq lsp-completion-show-detail t)
; emable lsp in all programming modes except emacs-lisp-mode
(add-hook 'prog-mode-hook (lambda ()
			    (unless (derived-mode-p 'emacs-lisp-mode)
			      (lsp))))
(add-hook 'after-init-hook 'global-company-mode) ; autocomplete
(setq company-idle-delay 0)
(setq company-dabbrev-downcase 0)
(setq company-dabbrev-other-buffers t)
(setq company-selection-wrap-around t)
(setq company-show-numbers t)
(setq company-tooltip-align-annotations t)
 ; highlight current line
(add-hook 'text-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)
; enable yas
; C/++ style
(setq c-default-style "k&r")
(setq-default c-basic-offset 4)
; hide toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)
; only spaces for indentation
(add-hook 'prog-mode-hook (lambda ()
			    (setq indent-tabs-mode nil)
			    (setq tab-width 4)))
(setq indent-tabs-mode nil)
; window management
(setq pop-up-windows t)           ; don't spawn new windows
(setq even-window-heights nil)      ; don't resize
(setq display-buffer-reuse-frames t)
(setq display-buffer-alist
      '((info-window-regex
	 (display-buffer-reuse-window display-buffer-at-bottom)
         (window-height . fit-window-to-buffer)
         (window-width . fit-window-to-buffer-horizontally))))
; smooth scrolling
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq scroll-step 1)
; clean up unused buffers
(setq clean-buffer-list-kill-never-buffer-names '("init.el"))
(setq clean-buffer-list-kill-regexps '(".+\\.c\\(pp\\)?")) ; C/C++
(setq clean-buffer-list-delay-special 3600) ; every hour
; dired-x
(add-hook 'dired-load-hook (lambda ()
			     (load "dired-x")))
; backup files
(setq make-backup-files nil)
; new file templates
(eval-after-load 'autoinsert
  '(progn
     (auto-insert-mode)
     (setq auto-insert-directory "~/.config/emacs/insert/")
     (setq auto-insert t)
     (define-auto-insert "\\.h$" ["template.h" autoinsert-yas-expand])
     (define-auto-insert "\\.sh$" ["template.sh" autoinsert-yas-expand])
     (define-auto-insert "^Makefile$" ["template.mk" autoinsert-yas-expand])
     (define-auto-insert "\\.html$" ["template.html" autoinsert-yas-expand])))
; tasks
(run-every-n-minutes 30 'clean-buffer-list)
; org mode
(setq org-export-in-background nil)
; html5
(setq org-html-doctype "html5")
(setq org-html-html5-fancy t)
(setq org-html-validation-link "")
; don't insert blank line before list entry
(setq org-blank-before-new-entry '((heading . auto)
                                   (plain-list-item . nil)))
; org publish stuff
(require 'ox-publish)
(setq org-publish-project-alist
      `(("pages"
         :base-directory "~/blog/org/"
         :base-extension "org"
         :recursive: nil
         :publishing-directory "~/blog/html/"
         :publishing-function org-html-publish-to-html
	     :html-head "<link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\"/>"
         ; options
         :html-head-include-default-style nil
         :html-head-include-scripts nil)
        ("posts"
	     :base-directory "~/blog/org/posts/"
	     :base-extension "org"
	     :recursive t
         ; include css
	     :html-head "<link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\"/>"
	     :publishing-directory "~/blog/html/posts/"
	     :publishing-function org-html-publish-to-html
         ; sitemap
         :auto-sitemap t
         :sitemap-title "Posts"
         :sitemap-filename "posts.org"
         ; newest to oldest
         :sitemap-sort-files anti-chronologically
         ; options
         :html-head-include-default-style nil
         :html-head-include-scripts nil)
	    ("css"
	     :base-directory "~/blog/org/css"
	     :base-extension "css"
	     :recursive t
	     :publishing-directory "~/blog/html/"
	     :publishing-function org-publish-attachment)
	    ("static"
	     :base-directory "~/blog/org/"
	     :base-extension "css\\|txt\\|jpg\\|gif\\|png\\|webp"
	     :recursive t
	     :publishing-directory "~/blog/html/"
	     :publishing-function org-publish-attachment)
	    ("blog" :components ("posts" "pages" "static" "css"))))

;; keybindings
; zoom with mouse
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)
(global-set-key (kbd "C-M-c") 'undefined)
(global-set-key (kbd "C-M-v") 'undefined)
(global-set-key (kbd "C-M-c") 'kill-ring-save)
(global-set-key (kbd "C-M-v") 'yank)
(global-set-key (kbd "C-;") 'ace-window)
; yas stuff
(define-key yas-minor-mode-map [(tab)] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
; evil stuff
(eval-after-load 'evil
  '(progn
     (evil-global-set-key 'normal (kbd "TAB") 'left-side-dired)
     (evil-global-set-key 'normal (kbd ";") 'evil-ex)
     (evil-global-set-key 'normal (kbd "C-o") 'open-in-program)))
(evil-select-search-module 'evil-search-module 'evil-search) ; use vim-like search
; disable dired warning for 'o' key
(put 'dired-find-alternate-file 'disabled nil)
