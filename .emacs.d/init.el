(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))



;; credit: yorickvP on Github
(setq wl-copy-process nil)
(defun wl-copy (text)
  (setq wl-copy-process
	(make-process :name "wl-copy"
                      :buffer nil
                      :command '("wl-copy" "-f" "-n")
                      :connection-type 'pipe
                      :noquery t))
  (process-send-string wl-copy-process text)
  (process-send-eof wl-copy-process))
(defun wl-paste ()
  (if (and wl-copy-process (process-live-p wl-copy-process))
      nil ; should return nil if we're the current paste owner
    (shell-command-to-string "wl-paste -n | tr -d \r")))
(setq interprogram-cut-function 'wl-copy)
(setq interprogram-paste-function 'wl-paste)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(send-mail-function 'sendmail-send-it)
 '(sendmail-program "msmtp")
 '(user-mail-address "gyuchen86@gmail.com")
 '(mail-specify-envelope-from t)
 '(message-sendmail-envelope-from 'header)
 '(mail-envelope-from 'header)
 '(auto-fill-function 'do-auto-fill t)
 '(default-input-method "german-postfix")
 '(modus-themes-bold-constructs t)
 '(modus-themes-inhibit-reload nil)
 '(modus-themes-italic-constructs t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(mode-line-compact 'long)
 '(read-buffer-completion-ignore-case t)
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(custom-enabled-themes '(modus-operandi)))

(use-package tex-site
  :straight auctex)

(use-package pyim
  :straight t)

;; basedict comes after pyim
(use-package pyim-basedict
  :straight t
  :config
  (pyim-basedict-enable))

(use-package shr
  :custom
  (shr-cookie-policy nil)
  (shr-inhibit-images t)
  (shr-use-colors nil))

(use-package files
  :custom
  (require-final-newline t))

(use-package minibuffer
  :custom
  (read-file-name-completion-ignore-case t))

(use-package mwheel
  :custom
  (mouse-wheel-mode nil))

(use-package simple
  :custom
  (indent-tabs-mode nil))

;; must be after modus-themes
(use-package custom
  :config
  ;; swap backspace and C-h
  (define-key key-translation-map [?\C-h] [?\C-?])
  (define-key key-translation-map [?\M-h] [?\M-\d])
  (define-key key-translation-map [?\M-\d] [?\M-h])
  ;; swap backspace and C-h ends here
  :custom
  (custom-enabled-themes '(modus-operandi)))

(use-package auth-source
  :custom
  (auth-sources '((concat (getenv "HOME") "/.password-store/authinfo.gpg"))))

(use-package elec-pair
  :custom
  (electric-pair-mode t))

(use-package battery
  :custom
  (display-battery-mode t))

(use-package time
  :custom
  (display-time-mode t))

;; ispell, multilingual spellchecking
;; https://www.monotux.tech/posts/2021/02/hunspell-multi-lang/
(use-package ispell
  :custom
  (ispell-program-name "hunspell")
  (ispell-dictionary "de_DE,en_US")
  :config
  (setenv "LANG" "en_US.UTF-8")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "de_DE,en_US"))

(use-package dired
  :config
  (defun dired-open-pdf ()
    "In dired, open the file named on this line."
    (interactive)
    (let* ((file (dired-get-filename nil t)))
      (call-process "zathura" nil 0 nil file)))
  :bind
  (:map dired-mode-map
        ("C-o" . dired-open-pdf)))

(use-package mu4e
  :config
  (set-variable 'read-mail-command 'mu4e)
  (setq mu4e-contexts
        ; (info "(mu4e)Contexts example")
        `(,(make-mu4e-context
            :name "Private"
            :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/gmail" (mu4e-message-field msg :maildir))))
            :vars
            '((user-mail-address . "gyuchen86@gmail.com")
              (user-full-name . "Yuchen Guo")
              (message-user-organization . "Tieling")
              (mu4e-sent-folder . "/gmail/Sent/")
              (mu4e-drafts-folder . "/gmail/Drafts/")
              (mu4e-trash-folder . "/gmail/Trash/")
              (mu4e-refile-folder . "/gmail/Archive/")
              (mu4e-compose-signature . (concat "Yuchen Guo\n"))))))
  :custom
  (mu4e-context-policy 'pick-first)
  (mu4e-compose-context-policy nil)
  (message-kill-buffer-on-exit t)
  (mail-user-agent 'mu4e-user-agent)
  (mu4e-sent-messages-behavior 'sent)
  (mu4e-change-filenames-when-moving t)
  (mu4e-get-mail-command "mbsync -a")
  (mu4e-attachment-dir "~/Downloads/"))

(use-package latex
  :hook
  ((LaTeX-mode . turn-on-reftex)
   (LaTeX-mode . prettify-symbols-mode)
   (LaTeX-mode . TeX-source-correlate-mode)
   (LaTeX-mode . LaTeX-math-mode))
  :custom
  (prettify-symbols-unprettify-at-point nil)
  (TeX-source-correlate-start-server t)
  (TeX-PDF-from-DVI nil)
  (TeX-view-program-selection '((output-pdf "Zathura")))
  (TeX-PDF-mode t)
  (TeX-save-query nil)
  (TeX-engine 'default)
  (LaTeX-electric-left-right-brace t)
  (TeX-auto-save t)
  (TeX-debug-bad-boxes t)
  (TeX-debug-warnings t)
  (TeX-electric-math '("\\(" . "\\)"))
  (TeX-electric-sub-and-superscript t)
  (reftex-plug-into-AUCTeX t)
  (LaTeX-math-list
   '(("o r" "mathbb{R}" nil nil)
     ("o Q" "qquad" nil nil)
     ("o q" "quad" nil nil)
     ("o n" "mathbb{N}" nil nil)
     (?= "coloneq" nil nil)
     ("o c" "mathbb{C}" nil nil)))
  (ispell-tex-skip-alists
   (list
    (append
     (car ispell-tex-skip-alists)
     ;; https://emacs.stackexchange.com/a/19650
     '(("\\\\[[]" . "\\\\[]]")))
    (cadr ispell-tex-skip-alists)))
  :bind
  (:map TeX-mode-map
        ("<f8>" . TeX-command-run-all))
  :config
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer)
  (dolist (symb
           '(("\\(" . ?⌜)
             ("\\)" . ?⌟)
             ("\\colon" . ?:)
             ("\\mathbb{C}" . ?ℂ)
             ("\\mathbb{K}" . ?𝕂)))
    (add-to-list 'tex--prettify-symbols-alist symb))
  :straight nil)

(use-package magit
  :straight t)
