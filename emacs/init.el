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
   '(ace-window dired-x magit company lsp-mode gruvbox-theme evil)))
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

(require 'evil)
(require 'lsp-mode)

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

(defun find-notes-file ()
  (interactive)
  (find-file "~/notes.org"))

(defun open-in-program ()
  "Opens BUFFER in a program based on its file extension"
  (interactive)

  (let* ((extension (file-name-extension (buffer-file-name (current-buffer))))
	 (command (cond ((string= extension "html") "chromium"))))
    (async-shell-command (concat command " " (buffer-file-name (current-buffer))))))


;; aesthetic settings
(set-face-attribute 'default nil
		    :font "undefined medium"
		    :height 80)
(setq default-frame-alist '((font . "undefined medium")))
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
 ; highlight current line
(add-hook 'text-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)
; hide toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)
; only spaces for indentation
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
; tasks
(run-every-n-minutes 30 'clean-buffer-list)
; org mode
(setq org-export-in-background nil)
; html5
(setq org-html-doctype "xhtml5")
(setq org-html-html5-fancy t)

;; keybindings
; zoom with mouse
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)
(global-set-key (kbd "C-M-c") 'undefined)
(global-set-key (kbd "C-M-v") 'undefined)
(global-set-key (kbd "C-M-c") 'kill-ring-save)
(global-set-key (kbd "C-M-v") 'yank)
; evil stuff
(eval-after-load 'evil
  '(progn
     (evil-global-set-key 'normal (kbd "TAB") 'left-side-dired)
     (evil-global-set-key 'normal (kbd ":") 'ace-window)
     (evil-global-set-key 'normal (kbd ";") 'evil-ex)
     (evil-global-set-key 'normal (kbd "C-o") 'open-in-program)))
(evil-select-search-module 'evil-search-module 'evil-search) ; use vim-like search
; disable dired warning for 'o' key
(put 'dired-find-alternate-file 'disabled nil)
