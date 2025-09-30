;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Pavel Sushkevich"
      user-mail-address "sushkevichpavel@gmail.com")

(menu-bar-mode 0)

;; Разворачивать на весь экран. Есть проблемма с перекрытием верхнего меню
;; (add-hook 'window-setup-hook #'toggle-frame-maximized)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:

(setq doom-font (font-spec :family "JetBrains Mono" :size 14))
(setq doom-variable-pitch-font (font-spec :family "PT Sans" :size 16))
(setq doom-serif-font (font-spec :family "JetBrains Mono" :size 14))

(setq org-hide-emphasis-markers t)
(add-hook 'org-mode-hook
  (lambda ()
    ;; (variable-pitch-mode 1)
    ;; (setq org-modern-variable-pitch nil)
    ;; (setq modus-themes-mixed-fonts t)
    ;; (setq org-modern-hide-stars nil)
    ;; (face-remap-add-relative 'default :family "PT Sans" :height 160)
    ;; (set (make-local-variable 'face-remapping-alist)
    ;;      '((default . (:family "PT Sans" :height 160))
    ;;        (fixed-pitch . (:family "JetBrains Mono" :height 140))
    ;;        (variable-pitch . (:family "PT Sans" :height 160))))

    ;; Not bad fonts
    ;; (set-fontset-font t 'cyrillic (font-spec :family "Inter"))
    ;; (set-fontset-font t 'cyrillic (font-spec :family "Open Sans"))
    ;; (set-fontset-font t 'cyrillic (font-spec :family "Manrope"))
    ;; (set-fontset-font t 'cyrillic (font-spec :family "IBMPlex Sans"))
    ;; (set-fontset-font t 'cyrillic (font-spec :family "PT Sans" :size 16))
    ;; (set-fontset-font t 'latin (font-spec :family "PT Sans" :size 16))
    ;; (set-fontset-font t 'cyrillic (font-spec :family "JetBrains Mono"))
    ;; (set-fontset-font t 'cyrillic (font-spec :family "FiraGo"))

    (set-face-attribute 'cursor nil :family "JetBrains Mono")
    (set-face-attribute 'org-table nil :inherit 'fixed-pitch)

    ;; Вертикальный курсор
    (setq-local cursor-type 'bar)
    ;; Растягивание курсора
    (setq-local x-stretch-cursor t)
    (hl-line-mode -1)

    (visual-line-mode 1)  ;; Мягкий перенос строк (НЕ добавляет разрывы)
    (auto-fill-mode -1)   ;; Отключаем авторазрывы строк
    ;; Отключено на время войны с шрифтами
    (visual-fill-column-mode 1)
    (setq visual-fill-column-width 100)
    (setq visual-fill-column-center-text t)

    (setq display-line-numbers nil)  ;; Отключает номера строк
    (add-hook 'org-table-mode-hook (lambda () (visual-fill-column-mode -1)) 'append)

    (setq-local company-idle-delay 0.5)
))

(defun unfill-paragraph ()
  "Превращает текущий параграф в одну длинную строку."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))
(global-set-key (kbd "M-Q") 'unfill-paragraph) ;; Используй `M-Q` для обратного `M-q`

;; Включаем автоматическое сохранение сессии
;; (setq desktop-dirname "~/.emacs.d/desktop/"
;;       desktop-path (list desktop-dirname)
;;       desktop-save t
;;       desktop-auto-save-timeout 10)  ;; Автосохранение каждые 10 сек

;; Включаем восстановление сессии при запуске
;; (desktop-save-mode 1)

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; (setq doom-theme 'doom-nord)
(setq doom-theme 'modus-operandi)
;; (setq doom-theme 'doom-nord-light)
;; (setq doom-theme 'leuven)

;; workaround for large title bar on macOS Sonoma
(add-hook 'doom-after-init-hook (lambda () (tool-bar-mode 1) (tool-bar-mode 0)))
;;remove ugly tildas (empty lines indicator) from left fringe
(remove-hook 'text-mode-hook #'vi-tilde-fringe-mode)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)
(global-display-line-numbers-mode 1)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")
(setq org-roam-directory "~/org/notes")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq lsp-idle-delay 0.5)
;; assign ALT-ENTER to lsp-find-definition
(bind-key "M-<return>" 'lsp-find-definition)

(use-package! websocket :after org-roam)
(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))


(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package! gptel
 :config
 (setq! gptel-api-key (getenv "OPENAI_API_KEY")))

;; (use-package! lsp-mode
;;   :hook (ruby-mode . lsp)
;;   :config
;;   (setq lsp-disabled-clients '(ruby-ls rubocop-ls)
;;         lsp-solargraph-use-bundler nil
;;         lsp-completion-provider :capf))
;;
;;
;; (add-to-list 'exec-path "/Users/pavel/.rvm/gems/ruby-3.2.2/bin")
;; (setq lsp-solargraph-server-command '("/Users/pavel/.rvm/gems/ruby-3.2.2/bin/solargraph" "stdio"))
(setq lsp-log-io nil)
(setq lsp-use-plists t)

(after! lsp-mode
  (setq lsp-pyright-multi-root nil   ;; Отключает поддержку нескольких корней (если проблемы)
        lsp-pyright-auto-import-completions t
        lsp-pyright-diagnostic-mode "workspace"
        lsp-pyright-typechecking-mode "basic")) ;; Можно "strict" для более строгой проверки

(after! ruby-mode
  (setq flycheck-checker 'ruby-rubocop)
  (setq-default flycheck-disabled-checkers '(ruby-reek ruby-rubylint)))
(after! flycheck
  (setq flycheck-checker-error-threshold 10000)
  (setq flycheck-idle-change-delay 3)
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

(setq flycheck-command-wrapper-function
  (lambda (command) (append '("bundle" "exec") command)))

(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (ruby "https://github.com/tree-sitter/tree-sitter-ruby")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

(add-to-list 'treesit-extra-load-path "/Users/pavel/.emacs.d/.local/straight/build-29.1/tree-sitter-langs/bin/")
(setq treesit-load-name-override-list '((ruby "ruby" "tree_sitter_ruby")))
(setq major-mode-remap-alist
  '((ruby-mode . ruby-ts-mode)
    (python-mode . python-ts-mode)))

(use-package! blacken
  :hook (python-mode . blacken-mode)
  :config
  (setq blacken-line-length 88))

;; configure current input method in doom-modeline
(after! doom-modeline
  (defun my/input-method-indicator ()
    (if current-input-method (format "%s" current-input-method-title) "EN"))

  (doom-modeline-def-segment input-method (my/input-method-indicator))

  (doom-modeline-def-modeline 'my-simple-line
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes input-method buffer-encoding major-mode process vcs check))

  (defun set-my-simple-modeline ()
    (doom-modeline-set-modeline 'my-simple-line 'default))

  (add-hook 'doom-modeline-mode-hook #'set-my-simple-modeline)
  (add-hook 'after-change-major-mode-hook #'set-my-simple-modeline))

(bind-key "s-d" 'duplicate-line)
(bind-key "s-}" 'next-buffer)
(bind-key "s-{" 'previous-buffer)

(bind-key "M-n" 'scroll-up-line)
(bind-key "M-p" 'scroll-down-line)
(bind-key "M-o" 'other-window)

;; Needed for `:after char-fold' to work
(use-package char-fold
  :custom
  (char-fold-symmetric t)
  (search-default-mode #'char-fold-to-regexp))

(use-package reverse-im
  :ensure t ; install `reverse-im' using package.el
  :demand t ; always load it
  :after char-fold ; but only after `char-fold' is loaded
  :bind
  ("M-T" . reverse-im-translate-word) ; fix a word in wrong layout
  :custom
  ;; cache generated keymaps
  (reverse-im-cache-file (locate-user-emacs-file "reverse-im-cache.el"))
  ;; use lax matching
  (reverse-im-char-fold t)
  (reverse-im-read-char-advice-function #'reverse-im-read-char-include)
  ;; translate these methods
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t)) ; turn the mode on

(setq org-time-stamp-custom-formats '("%d.%m.%Y"))
(setq org-display-custom-times t)  ;; Включает отображение в кастомном формате
