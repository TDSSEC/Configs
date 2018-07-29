(setq gc-cons-threshold 50000000)
(setq gnutls-min-prime-bits 4096)

(require 'package)

(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "http://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

(package-initialize)
;; may want to comment the next line after initial launch
;;(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-mobile-sync auto-org-md org-bullets cheat-sh markdown-mode all-the-icons-ivy counsel all-the-icons neotree tabbar atom-dark-theme smartparens mode-icons spaceline use-package)))
 '(tabbar-separator (quote (0.5))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Save state
(desktop-save-mode 1)

;; Always use utf-8
(set-charset-priority 'unicode)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Remove alarm bell
(setq ring-bell-function 'ignore)

;; Syntax Highlighting
(global-font-lock-mode 1)

;; Wrap Text
(global-visual-line-mode t)

;; Line numbers and binding to a command to flick
(require 'linum)
(global-set-key (kbd "C-c l") 'global-linum-mode)
;; line number looking good.
(setq linum-format "%d ")

;; Column numbers
(setq column-number-mode t)

;; dont type yes or no all the time
(fset 'yes-or-no-p 'y-or-n-p)

;; Auto update buffers
(global-auto-revert-mode t)

;; Stop temp files
(setq create-lockfiles nil)

;; stop making crap
(setq make-backup-files nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Remove startup buffers
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
(setq inhibit-startup-message t)
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; remove scratch messages
(setq initial-scratch-message "")

;; making the scratch page org mode
(setq initial-major-mode 'org-mode)

;; Highlight current line
(global-hl-line-mode 1)

;; Hide the mouse whilst typing
(setq make-pointer-invisible t)

;; C-x C-r to show Recent Files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; delete selected region whilst typing
(delete-selection-mode 1)

;; kill current buffer
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-current-buffer)

;; THEMES
;; set date and time
(setq display-time-day-and-date t)
(display-time)

;; Spaceline (bottom bar)
(use-package spaceline
  :ensure t
  :init
  (require 'spaceline-config)
  :config
  (spaceline-spacemacs-theme)
;;(custom-set-faces
;; '(mode-line ((t (:foreground "black" :background "white" :box nil))))
;; '(mode-line-inactive ((t (:foreground "white" :background "black" :box nil)))))
)

;; Mode icons
(use-package mode-icons
  :ensure t
  :config (mode-icons-mode))

;; smart parenthesis
(use-package smartparens
:diminish smartparens-mode
:config
(smartparens-global-mode)
)

;; Cycle through Themes
(use-package atom-dark-theme
  :ensure t)

   (setq my-themes '(atom-dark adwaita))
   (setq my-cur-theme nil)
   (defun cycle-my-theme ()
     "Cycle through a list o themes, myf-themes"
     (interactive)
     (when my-cur-theme
	(disable-theme my-cur-theme)
	(setq my-themes (append my-themes (list my-cur-theme))))
     (setq my-cur-theme (pop my-themes))
     (load-theme my-cur-theme t))
   (defadvice load-theme (before clear-previous-themes activate)
     "Clear existing theme settings instead of layering them"
(mapc #'disable-theme custom-enabled-themes))
(cycle-my-theme)
(global-set-key (kbd "C-t") 'cycle-my-theme)

;; Packages
;; tabbar
(use-package tabbar
  :ensure t
  :config
  (tabbar-mode t))
;; sort tabbar buffers by name
 (defun tabbar-add-tab (tabset object &optional append_ignored)
     "Add to TABSET a tab with value OBJECT if there isn't one there yet.
    If the tab is added, it is added at the beginning of the tab list,
    unless the optional argument APPEND is non-nil, in which case it is
    added at the end."
     (let ((tabs (tabbar-tabs tabset)))
       (if (tabbar-get-tab object tabset)
           tabs
         (let ((tab (tabbar-make-tab object tabset)))
           (tabbar-set-template tabset nil)
           (set tabset (sort (cons tab tabs)
                             (lambda (a b) (string< (buffer-name (car a)) (buffer-name (car b))))))))))
;; sizing
(set-face-attribute
 'tabbar-separator nil
 :background "gray20"
 :height 2.0)
(set-face-attribute
 'tabbar-default nil
 :height 130
 :background "gray20"
 :foreground "gray20"
 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-unselected nil
 :background "gray30"
 :foreground "white"
 :box '(:line-width 5 :color "gray30" :style nil))
(set-face-attribute
 'tabbar-selected nil
 :background "gray75"
 :foreground "black"
 :box '(:line-width 5 :color "gray75" :style nil))
(set-face-attribute
 'tabbar-highlight nil
 :background "white"
 :foreground "black"
 :underline nil
 :box '(:line-width 5 :color "white" :style nil))
(set-face-attribute
 'tabbar-button nil
:box '(:line-width 1 :color "gray20" :style nil))
;; unknown settings

;; adding spaces
(defun tabbar-buffer-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label  (if tabbar--buffer-show-groups
                    (format "[%s]  " (tabbar-tab-tabset tab))
                  (format "%s  " (tabbar-tab-value tab)))))
    ;; Unless the tab bar auto scrolls to keep the selected tab
    ;; visible, shorten the tab label to keep as many tabs as possible
    ;; in the visible area of the tab bar.
    (if tabbar-auto-scroll-flag
        label
      (tabbar-shorten
       label (max 1 (/ (window-width)
                       (length (tabbar-view
                                (tabbar-current-tabset)))))))))

(tabbar-mode 1)

;; Neotree (Thing on the left)
(use-package neotree
  :ensure t
  :config
  (global-set-key [f8] 'neotree-toggle))
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;; all the icons
(use-package all-the-icons
  :ensure t)

;; multiple cursors
(use-package multiple-cursors
:ensure t
:bind (("C-c d" . mc/edit-lines)
("C->" . mc/mark-next-like-this)
("C-<" . mc/mark-previous-like-this)
("C-c C-<" . mc/mark-all-like-this)
))

;; ivy mode (mini buffer made better)
(use-package ivy
:ensure t)
(use-package counsel
:ensure t)
(use-package swiper    
  :ensure t    
  :bind    
  (("C-s" . swiper)    
   ("M-x" . counsel-M-x)    
   ("C-x C-f" . counsel-find-file)    
   ("C-x l" . counsel-locate)    
   ("C-c C-r" . ivy-resume)
   ("C-r" . counsel-expression-history))
  :config    
  (ivy-mode 1)
  (setq ivy-count-format "(%d/%d) ")
)
  (use-package all-the-icons-ivy
    :ensure t
    :config
    (all-the-icons-ivy-setup))

;; Yasnippet (autocomplete from template)
;;(use-package yasnippet-snippets
;; :ensure t)

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode t)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-reload-all))

;; markdown
(use-package markdown-mode
  :mode "\\.md\\'"
  :ensure t)

;; cheat sheet (quick man page)
(use-package cheat-sh
  :ensure t)

;; ORG MODE
(use-package org
 :ensure t)
;; Stop exports from numbering headings
(setq org-export-with-section-numbers nil)
;; bullets instead of stars
(use-package org-bullets
   :ensure t
   :init (add-hook 'org-mode-hook 'org-bullets-mode))
;; hide leading stars
(setq org-hide-leading-stars t)
;; syntax highlight code-blocks
(setq org-src-fontify-natively t)
;; tab working
(setq org-src-tab-acts-natively t)
;; exclude footer
(setq org-html-postamble nil)

;; Org babel (executing code)
(defadvice org-babel-execute-src-block (around load-language nil activate)
  "Load language if needed"
  (let ((language (org-element-property :language (org-element-at-point))))
    (unless (cdr (assoc (intern language) org-babel-load-languages))
      (add-to-list 'org-babel-load-languages (cons (intern language) t))
      (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))
    ad-do-it))
    ;; dont ask just run the code block
(setq org-confirm-babel-evaluate nil)
;; Set python3
(setq org-babel-python-command "python3")
