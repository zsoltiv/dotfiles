(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(initial-buffer-choice t)
 '(initial-scratch-message "")
 '(package-selected-packages '(magit company lsp-mode gruvbox-theme evil)))
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

(require 'evil)
(require 'lsp-mode)


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
  (interactive)

  `(run-with-timer 0 (* ,n 60) ,exp))


(defun custom-welcome-screen ()
  "Custom welcome screen"
  (interactive)

  (let* ((welcome-buffer (get-buffer-create "*Welcome buffer*"))
	 (ascii-text     '("        _                  __        __            ___     \n"
			   " _   __(_)______  ______ _/ /  _____/ /___  ______/ (_)___ \n"
			   "| | / / / ___/ / / / __ `/ /  / ___/ __/ / / / __  / / __ \\\n"
			   "| |/ / (__  ) /_/ / /_/ / /  (__  ) /_/ /_/ / /_/ / / /_/ /\n"
			   "|___/_/____/\\__,_/\\__,_/_/  /____/\\__/\\__,_/\\__,_/_/\\____/ \n"
			   "                  __   \n"
	                   "  _________  ____/ /__ \n"
			   " / ___/ __ \\/ __  / _ \\\n"
			   "/ /__/ /_/ / /_/ /  __/\n"
			   "\\___/\\____/\\__,_/\\___/ \n"))
	 ; the longest line in ascii-text
	 (length         (- (apply 'max (mapcar 'length ascii-text)) 1))
         (width          (window-body-width nil))
         (height         (- (window-body-height nil) 1))
	 (padding-left   (- (/ width 2) (/ length 2)))
         (padding-top    (- (/ height 2) 1))
         (padding-bottom (- height (/ height 2) 3)))

    (with-current-buffer welcome-buffer
      (erase-buffer)
      (if (one-window-p)
          (setq mode-line-format nil))
      (setq cursor-type nil)
      (setq vertical-scroll-bar nil)
      (setq horizontal-scroll-bar nil)
      (setq fill-column width)

      ; padding
      (insert-char ?\n padding-top)

      (dolist (line ascii-text)
	(insert-char ?  padding-left)
	(insert line))

      (insert-char ?\n padding-bottom)

      (switch-to-buffer welcome-buffer)
      ; go to the beginning of the buffer
      (goto-char 0))))


;; aesthetic settings
(set-face-attribute 'default nil
		    :font "undefined medium"
		    :height 80)
(load-theme 'gruvbox t)
(add-hook 'emacs-startup-hook 'custom-welcome-screen)


;; rest of the config
(evil-mode 1) ; use evil mode
; relative line numbers
(add-hook 'text-mode-hook 'display-relative-line-numbers-mode)
(add-hook 'prog-mode-hook 'display-relative-line-numbers-mode)
; lsp
(setq lsp-clangd-binary-path "/usr/lib/llvm/12/bin/clangd")
(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-ui-sideline-enable nil)
(setq lsp-completion-show-detail nil)

; emable lsp in all programming modes except emacs-lisp-mode
(add-hook 'prog-mode-hook (lambda ()
			    (unless (derived-mode-p 'emacs-lisp-mode)
			      (lsp))))
(add-hook 'after-init-hook 'global-company-mode) ; autocomplete
; hide toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)
; only spaces for indentation
(setq indent-tabs-mode nil)
; smooth scrolling
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq scroll-step 1)
; clean up unused buffers
(setq clean-buffer-list-kill-never-buffer-names '("init.el"))
(setq clean-buffer-list-kill-regexps '(".+\\.c\\(pp\\)?")) ; C/C++
(setq clean-buffer-list-delay-special 3600) ; every hour
; tasks
(run-every-n-minutes 30 'clean-buffer-list)


;; keybindings
(eval-after-load 'evil
  '(progn
     (evil-global-set-key 'normal (kbd "TAB") 'dired-jump)
     (evil-global-set-key 'normal (kbd ":") 'evil-ex)
     (evil-global-set-key 'normal (kbd ";") 'evil-ex)))
;(evil-global-set-key 'normal (kbd ";") )
