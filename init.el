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

;;(use-package auto-compile
 ;; :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (markdown-mode zenburn-theme cyberpunk-theme madhat2r-theme calfw-cal calfw-org calfw dockerfile-mode counsel idea-darkula-theme use-package)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
;; Theme
(load-theme 'idea-darkula t)

;; Time at bottom right
(setq display-time-day-and-date t)
(display-time)

;; ivy - better buffer
(use-package ivy
:ensure t
:diminish ivy-mode)
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

;; Syntax for Docker
(use-package dockerfile-mode
:ensure t
:init (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

;; Agenda
(setq org-agenda-files (list "~/Documents/org/index.org"))
(global-set-key (kbd "C-c a") 'org-agenda)

;; Alarm Bell - disable
(setq ring-bell-function 'ignore)

;; highlight current line
(global-hl-line-mode 1)

;; add calendar
(use-package calfw
  :ensure t)
(use-package calfw-org
  :ensure t
  :bind ("C-c c" . cfw:open-org-calendar)
  :config
  (setq cfw:org-overwrite-default-keybinding t)
  (setq cfw:org-agenda-schedule-args '(:timestamp))
  )

;; Ansi term
(global-set-key (kbd "C-c t") '(lambda ()(interactive)(ansi-term "/bin/zsh")))
;; Fix some weird color escape sequences
(setq system-uses-terminfo nil)
;; make copy/paste feel better
(defun my-term-mode-hook ()
  (define-key term-raw-map (kbd "C-y") 'term-paste)
  (define-key term-raw-map (kbd "C-k")
    (lambda ()
      (interactive)
      (term-send-raw-string "\C-k")
      (kill-line))))
(add-hook 'term-mode-hook 'my-term-mode-hook)

;; right click copy
(defadvice mouse-save-then-kill (around mouse2-copy-region activate)
  (when (region-active-p)
    (copy-region-as-kill (region-beginning) (region-end)))
  ad-do-it)

;; Remove the startup message
(setq inhibit-startup-message t) 

;; Themes - Changing them and keybinding
  (use-package madhat2r-theme
    :ensure t)
(use-package cyberpunk-theme
  :ensure t)
(use-package zenburn-theme
  :ensure t)

(setq my-themes '(madhat2r cyberpunk zenburn))
(setq my-cur-theme nil)
(defun cycle-my-theme ()
  "Cycle through a list of themes, my-themes"
  (interactive)
  (when my-cur-theme
    (disable-theme my-cur-theme)
    (setq my-themes (append my-themes (list my-cur-theme))))
  (setq my-cur-theme (pop my-themes))
  (load-theme my-cur-theme t))
;;Switch to the first theme in the list above
(cycle-my-theme)
;;Keyboard binding to switch themes
(global-set-key (kbd "C-t") 'cycle-my-theme)
