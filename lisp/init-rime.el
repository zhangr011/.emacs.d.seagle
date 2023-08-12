;; init-rime.el

;; (setq rime-emacs-module-header-root "/opt/homebrew/Cellar/emacs/28.2/include")
(setq rime-emacs-module-header-root "/opt/homebrew/Cellar/emacs-mac/emacs-29.1-mac-10.0/include")

(use-package rime
  :custom
  (default-input-method "rime")
  (rime-librime-root "~/.emacs.d/librime/dist")
  (rime-disable-predicates '(rime-predicate-after-alphabet-char-p
                             rime-predicate-prog-in-code-p
                             rime-predicate-in-code-string-p
                             rime-predicate-space-after-cc-p
                             rime-predicate-current-uppercase-letter-p))
  (rime-show-candidate 'posframe)

  :hook
  ('kill-emacs . (lambda ()
                   (when (fboundp 'rime-lib-sync-user-data)
                     (ignore-errors (rime-sync)))))
  )

(provide 'init-rime)
