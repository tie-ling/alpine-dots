(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-fill-function 'do-auto-fill t)
 '(custom-enabled-themes '(modus-operandi) nil nil "Customized with use-package custom")
 '(default-input-method "german-postfix")
 '(inhibit-startup-screen t)
 '(mail-envelope-from 'header)
 '(mail-specify-envelope-from t)
 '(menu-bar-mode nil)
 '(message-sendmail-envelope-from 'header)
 '(mode-line-compact 'long)
 '(modus-themes-bold-constructs nil)
 '(modus-themes-inhibit-reload nil)
 '(modus-themes-italic-constructs t)
 '(modus-themes-mixed-fonts t)
 '(modus-themes-variable-pitch-ui t)
 '(read-buffer-completion-ignore-case t)
 '(ring-bell-function nil)
 '(scroll-bar-mode nil)
 '(send-mail-function 'sendmail-send-it)
 '(sendmail-program "msmtp")
 '(tool-bar-mode nil)
 '(user-mail-address "gyuchen86@gmail.com"))

(use-package pyim)

;; basedict comes after pyim
(use-package pyim-basedict
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

(use-package nix-mode)

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
              (mu4e-sent-folder . "/gmail/[Gmail]/Sent Mail/")
              (mu4e-drafts-folder . "/gmail/[Gmail]/Drafts/")
              (mu4e-trash-folder . "/gmail/[Gmail]/Trash/")
              (mu4e-refile-folder . "/gmail/[Gmail]/Important/")
              (mu4e-compose-signature . (concat "Yuchen Guo\n"))))
          ,(make-mu4e-context
            :name "posteo"
            :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/posteo" (mu4e-message-field msg :maildir))))
            :vars
            '((user-mail-address . "yguo@posteo.net")
              (user-full-name . "Yuchen Guo")
              (message-user-organization . "Tieling")
              (mu4e-sent-folder . "/posteo/Sent/")
              (mu4e-drafts-folder . "/posteo/Drafts/")
              (mu4e-trash-folder . "/posteo/Trash/")
              (mu4e-refile-folder . "/posteo/Notes/")
              (mu4e-compose-signature . (concat "Yuchen Guo\n"))))))
  :custom
  (mu4e-context-policy 'pick-first)
  (mu4e-compose-context-policy nil)
  (message-kill-buffer-on-exit t)
  (mail-user-agent 'mu4e-user-agent)
  (mu4e-sent-messages-behavior 'sent)
  (mu4e-change-filenames-when-moving t)
  (mu4e-get-mail-command "true")
  (mu4e-attachment-dir (concat (getenv "HOME") "/Downloads/")))

(use-package Info
  :hook
  ((Info-mode . variable-pitch-mode)))

(use-package text-mode
  :hook
  ((text-mode . variable-pitch-mode)))

(use-package latex
  :hook
  ((LaTeX-mode . turn-on-reftex)
   (LaTeX-mode . variable-pitch-mode)
   (LaTeX-mode . prettify-symbols-mode)
   (LaTeX-mode . TeX-source-correlate-mode)
   (LaTeX-mode . LaTeX-math-mode))
  :custom
  (prettify-symbols-unprettify-at-point nil)
  (TeX-engine 'luatex)
  (TeX-source-correlate-start-server t)
  (TeX-PDF-from-DVI nil)
  (TeX-view-program-selection '((output-pdf "Zathura")))
  (TeX-PDF-mode t)
  (TeX-save-query nil)
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
  (with-eval-after-load "tex-mode"
    (dolist (symb
             '(("\\(" . ?⌜)
               ("\\)" . ?⌟)
               ("\\colon" . ?:)
               ("\\mathbb{C}" . ?ℂ)
               ("\\mathbb{K}" . ?𝕂)))
      (add-to-list 'tex--prettify-symbols-alist symb))))


(use-package magit)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
