;; Emacs directory
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
;; Directory for custom module 
(add-to-list 'load-path "~/.emacs.d/custom")

;; Not Backup
(add-to-list 'backup-directory-alist
             (cons (expand-file-name "~/") (expand-file-name "~/backup/")))
(add-to-list 'auto-save-file-name-transforms
             `("~/\\([^/]*/\\)*\\([^/]*\\)$" "~/backup/\\2" t))

;; Package management
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; Load theme
(load-theme 'wombat t)
;;(load-theme 'tsdh-dark t)
;;(load-theme 'tango-dark t)
;;(load-theme 'wheatgrass t)
;;(load-theme 'misterioso t)

;; clipboard
(setq x-select-enable-clipboard t)

(defun package-install-with-refresh (package)
  (unless (assq package package-alist)
    (package-refresh-contents))
  (unless (package-installed-p package)
    (package-install package)))

;; Install package
;; operation
(package-install-with-refresh 'evil)
(package-install-with-refresh 'helm)
(package-install-with-refresh 'neotree)
(package-install-with-refresh 'ripgrep)
(package-install-with-refresh 'helm-ag)
(package-install-with-refresh 'helm-gtags)
(package-install-with-refresh 'helm-git-grep)
(package-install-with-refresh 'ace-jump-mode)
(package-install-with-refresh 'auto-complete)
(package-install-with-refresh 'company)
(package-install-with-refresh 'restart-emacs)
(package-install-with-refresh 'smartparens)
(package-install-with-refresh 'flycheck)
(package-install-with-refresh 'yasnippet)
(package-install-with-refresh 'yasnippet-snippets)
(package-install-with-refresh 'elpy)
(package-install-with-refresh 'magit)
(package-install-with-refresh 'evil-magit)
(package-install-with-refresh 'cl-lib)
(package-install-with-refresh 'meghanada)
(package-install-with-refresh 'f)

;; language
(package-install-with-refresh 'rjsx-mode)
(package-install-with-refresh 'web-mode)
(package-install-with-refresh 'fish-mode)
(package-install-with-refresh 'markdown-mode)
(package-install-with-refresh 'python-mode)
(package-install-with-refresh 'yaml-mode)
(package-install-with-refresh 'php-mode)
(package-install-with-refresh 'less-css-mode)
(package-install-with-refresh 'json-mode)
(package-install-with-refresh 'ess)
(package-install-with-refresh 'julia-mode)
(package-install-with-refresh 'ruby-mode)
(package-install-with-refresh 'pyenv-mode)
(package-install-with-refresh 'rust-mode)

;;remote
(package-install-with-refresh 'mustache-mode)
(require 'mustache-mode)
(require 'php-mode)

;; python
(elpy-enable)

(add-to-list 'exec-path "~/.pyenv/shims")

;; delete menu bar
(menu-bar-mode -1)

;; light parentheses
(show-paren-mode 1)
(defun electric-pair ()
  ;; Insert character pair without sournding spaces
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;; "yes or no" -> "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; no beep
(defun my-bell-function ()
  (unless (memq this-command
        '(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; Enable evil
(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map (kbd "SPC bb") 'helm-mini)
(add-hook 'neotree-mode-hook
	(lambda ()
	    (define-key evil-normal-state-local-map (kbd "l") 'neotree-enter)
	    (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
	    (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
	    (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
(global-set-key [f8] 'neotree-toggle)

;; Enable helm
(require 'helm)
(helm-mode 1)
(define-key evil-normal-state-map (kbd "SPC ff") 'helm-find-files)
;; helm-ag
(setq helm-ag-base-command "rg --vimgrep --no-heading")
(define-key evil-normal-state-map (kbd "SPC ag") 'helm-ag)
;; helm-git-grep
(require 'helm-git-grep)
(global-set-key (kbd "C-c g") 'helm-git-grep)
(define-key isearch-mode-map (kbd "C-c g") 'helm-git-grep-from-isearch)
(eval-after-load 'helm
  '(define-key helm-map (kbd "C-c g") 'helm-git-grep-from-helm))

;; magit
(setq global-magit-file-mode nil)
(setq magit-auto-revert-mode nil)
(require 'evil-magit)
(define-key evil-normal-state-map (kbd "SPC git") 'magit)

;; Enable company-mode
(require 'company)
(global-company-mode)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)

;; Enable auto-complete
;;(require 'auto-complete-config)
;;(ac-config-default)
;; (add-to-list 'ac-modes 'rjsx-mode)

;; Load other module
(require 'ace-jump-mode)
(define-key evil-normal-state-map (kbd "SPC j") 'ace-jump-word-mode)
(require 'smartparens-config)
(add-hook 'rjsx-mode-hook #'smartparens-mode)
(add-hook 'web-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
(add-hook 'php-mode-hook #'smartparens-mode)
(add-hook 'json-mode-hook #'smartparens-mode)
(add-hook 'javascript-mode-hook #'smartparens-mode)
(add-hook 'python-mode-hook #'smartparens-mode)
(add-hook 'julia-mode-hook #'smartparens-mode)
(add-hook 'ruby-mode-hook #'smartparens-mode)
(add-hook 'java-mode-hook #'smartparens-mode)

;; About rjsx-mode
(add-hook 'rjsx-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq js-indent-level 2)
            (setq js2-strict-missing-semi-warning nil)))

;; About web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(defun web-mode-hook ()
  (setq web-mode-markup-indent-offset 2)
  (add-hook 'web-mode-hook 'web-mode-hook))

;; python julia ruby
(require 'python)
(require 'julia-mode)

;; custom function
(defun open-emacs-conf ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; Evil KeyBind
(define-key evil-normal-state-map (kbd "SPC vv") 'split-window-horizontally)
(define-key evil-normal-state-map (kbd "SPC hh") 'split-window-vertically)
(define-key evil-normal-state-map (kbd "TAB k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "TAB j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "TAB l") 'evil-window-right)
(define-key evil-normal-state-map (kbd "TAB h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "SPC fed") 'open-emacs-conf)

;; Yasnippet

(add-to-list 'load-path
             (expand-file-name "/root/.emacs.d/elpa/yasnippet-20180319.607"))

(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
        "~/.emacs.d/yasnippets"
        ))

(define-key evil-normal-state-map (kbd "SPC yi") 'yas-insert-snippet)
(define-key evil-normal-state-map (kbd "SPC yn") 'yas-new-snippet)
(define-key evil-normal-state-map (kbd "SPC yv") 'yas-visit-snippet-file)
(yas-global-mode 1)

;; Prettier
(defun my/prettier ()
  (interactive)
  (shell-command
    (format "%s --write %s"
      (shell-quote-argument (executable-find "prettier"))
      (shell-quote-argument (expand-file-name buffer-file-name))))
  (revert-buffer t t t))
(define-key evil-normal-state-map (kbd "SPC cp") 'my/prettier)

;; gtags
(autoload 'gtags-mode "gtags" "" t)
(define-key evil-normal-state-map (kbd "SPC gf") 'helm-gtags-find-tag)
(define-key evil-normal-state-map (kbd "SPC gb") 'helm-gtags-pop-stack)
(add-hook 'php-mode-hook 'helm-gtags-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("59171e7f5270c0f8c28721bb96ae56d35f38a0d86da35eab4001aebbd99271a8" default)))
 '(package-selected-packages (quote (evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; meghanada
(require 'meghanada)
(add-hook 'java-mode-hook
          (lambda ()
            ;; meghanada-mode on
            (meghanada-mode t)
            (flycheck-mode +1)
            (setq c-basic-offset 2)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
(cond
   ((eq system-type 'windows-nt)
    (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
    (setq meghanada-maven-path "mvn.cmd"))
   (t
    (setq meghanada-java-path "java")
    (setq meghanada-maven-path "mvn")))
