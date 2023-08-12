
;; (use-package copilot
;;   :quelpa (copilot :fetcher github
;;                    :repo "zerolfx/copilot.el"
;;                    :branch "main"
;;                    :files ("dist" "*.el")))

;; you can utilize :map :hook and :config to customize copilot

(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t
  :bind (:map copilot-mode-map
         ("<tab>" . rk/copilot-accept-or-default)
         ("C-j" . rk/copilot-complete-or-accept)
         ("C-w" . copilot-accept-completion-by-word)
         ("C-l" . copilot-accept-completion-by-line)
         ("s-n" . copilot-next-completion)
         ("s-p" . copilot-previous-completion)
         ("s-w" . copilot-accept-completion-by-word)
         ("s-l" . copilot-accept-completion-by-line))

  :config
  (defun my/copilot-tab ()
    (interactive)
    (or (copilot-accept-completion)
        (indent-for-tab-command)))
  (defun rk/copilot-accept-or-default ()
    (interactive)
    (if (copilot--overlay-visible)
        (progn
          (copilot-accept-completion)
          (open-line 1)
          (next-line))
      (indent-for-tab-command)))
  (defun rk/copilot-complete-or-accept ()
    (interactive)
    (if (copilot--overlay-visible)
        (progn
          (copilot-accept-completion)
          (open-line 1)
          (next-line))
      (copilot-complete)))

  :hook
  (prog-mode . copilot-mode))

(provide 'init-copilot)
