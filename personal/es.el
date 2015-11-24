(prelude-require-packages '(solarized-theme deft ess))

(require 'ess-site)

(defconst organization "StatPro Italia s.r.l.")
(defconst user-mail-address "enrico.sirola@statpro.com")

;;; ----------------------------------------------------------------------
;;; keybindings
;;; ----------------------------------------------------------------------

(global-set-key (kbd "C-l") 'goto-line)

(defun es-switch-buffer ()
  (interactive)
  (helm
   :prompt "Switch to: "
   :candidate-number-limit 20            ;; up to 15 of each
   :sources
   '(helm-c-source-buffers-list          ; buffers
     helm-c-source-recentf               ; recent files
     helm-c-source-bookmarks             ; bookmarks
     helm-c-source-files-in-current-dir  ; current dir
     helm-c-source-locate)))

(global-set-key (kbd "<f6>") 'helm-find-files)
(global-set-key (kbd "<f5>") 'helm-projectile)
(global-set-key (kbd "<f9>") 'es-switch-buffer)
(global-set-key (kbd "<f1>") 'delete-other-windows)
;; manipolazione finestre + semplice
(global-set-key (kbd "S-<f1>") 'delete-window)
(global-set-key (kbd "<f2>") 'split-window-vertically)
(global-set-key (kbd "S-<f2>") 'split-window-horizontally)
(global-set-key (kbd "<f3>") 'next-buffer)
(global-set-key (kbd "S-<f3>") 'previous-buffer)
(global-set-key (kbd "<f4>") 'next-frame)
(global-set-key (kbd "S-<f4>") 'previous-frame)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "<f7>") 'execute-extended-command)
(global-set-key (kbd "<f10>") 'deft)
(global-set-key (kbd "<f11>") 'dired-jump)
(global-set-key (kbd "S-<f11>") 'dired-jump-other-window)
(global-set-key (kbd "C-<f11>") 'ido-dired)
(global-set-key (kbd "<f12>") 'shell)
(global-set-key (kbd "<f8>") ctl-x-map)

;; deft

;; ----------------------------------------------------------------------
;; org-mode
;; ----------------------------------------------------------------------

(when (>= emacs-major-version 23)
  (setq diary-file (expand-file-name "~/Dropbox/diary"))
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (setq org-agenda-include-diary t)
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c r") 'org-remember)
  (setq org-mobile-directory "~/Dropbox/MobileOrg"
        org-directory "~/Dropbox/org/"
        org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org"
        org-default-notes-file (concat org-directory "/notes.org"))
  (add-to-list 'Info-default-directory-list "~/Documents/info/"))

(setq org-hide-leading-stars t
      org-level-color-stars-only nil)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/todo.org") "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
         "* %?\nEntered on %U\n  %i\n  %a")))

;; ----------------------------------------------------------------------
;; deft
;; ----------------------------------------------------------------------

;(require 'deft)
;(setq deft-extension "org")
;(setq deft-text-mode 'org-mode)
;(setq deft-use-filename-as-title t)

;; ----------------------------------------------------------------------
;; aliases
;; ----------------------------------------------------------------------

(defalias 'dd 'dired)
(defalias 'vv 'vc-dir)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; ----------------------------------------------------------------------
;; osx tunings
;; ----------------------------------------------------------------------

(cond
 ((eq system-type 'darwin)
  (unless (null window-system)
    (dolist (v '((height . 45)
                 (width . 90)))
      (add-to-list 'initial-frame-alist v))
                                        ;(set-default-font
                                        ;"-apple-Menlo-medium-normal-normal-*-18-*-*-*-m-0-iso10646-1")
    )
  (setq helm-locate-command (concat "mdfind -onlyin "
				    (expand-file-name "~")
				    " -name %s %s")
        locate-command "mdfind")))
(cua-mode t)
(server-start)

(provide 'es)
