;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; ########################################################################################
;; PERSONAL CONFIG
;; ########################################################################################

(add-hook 'after-change-major-mode-hook #' (lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'after-change-major-mode-hook #' (lambda () (modify-syntax-entry ?- "w")))

;; Disable file watchers
(setq-default lsp-enable-file-watchers nil)

;; Set C/C++ conding style
(setq-default c-default-style "bsd")

;; Don't auto insert a newline at the end of a file
(setq-default require-final-newline nil
              c-require-final-newline nil
              mode-require-final-newline nil)

;; Swap split/split+follow keys (follow is preferred)
(map! :leader "w s" #'+evil/window-split-and-follow)
(map! :leader "w S" #'evil-window-split)
(map! :leader "w v" #'+evil/window-vsplit-and-follow)
(map! :leader "w V" #'evil-window-vsplit)

;; Swap toggle fullscreen and flycheck
(map! :leader "t f" #'toggle-frame-fullscreen)
(map! :leader "t F" #'flycheck-mode)

;; Keys to cycle through open buffers
(define-key evil-normal-state-map "_" 'previous-buffer)
(define-key evil-normal-state-map "+" 'next-buffer)

;; Useful keymaps
(map! :leader
      :desc "Toggle Comment"
      "/" #'comment-line)

(define-key global-map (kbd "C-s") 'basic-save-buffer)
(define-key global-map (kbd "S-s") 'basic-save-buffer)
(define-key global-map (kbd "C-/") 'comment-line)
(define-key global-map (kbd "S-/") 'comment-line)

;; TODO: Map these to better keys
;; Currently on M-p and M-n
;; In minibuffer-local-map or minibuffer-mode-map
;; previous-history-element
;; next-history-element

;; Render trailing whitespace
;; TODO: Don't render the trailing whitespace in the command bar
;; (setq-default show-trailing-whitespace t)

;; Don't trim trailing whitespace on file save
;; (remove-hook 'before-save-hook 'delete-trailing-whitespace)
(remove-hook 'before-save-hook 'ws-butler-before-save)

;; Create a snow-mode and activate it when the snow function runs
;; ###

(define-derived-mode snow-mode special-mode  "Let it snow!"
  "Major mode for *snow* buffers.")

(defun activate-snow-mode ()
  (interactive)
  (with-current-buffer (get-buffer "*snow*")
    (snow-mode)))

(advice-add 'snow :after #'activate-snow-mode)

;; ###

;; Check if not in fire or snow mode to zone out
(defun zone-if-not-fire-snow ()
  (interactive)
  (if (and (not (eq major-mode 'fireplace-mode))
           (not (eq major-mode 'snow-mode)))
      (zone)))

;; Zone out after 5 minutes
(setq zone-timer (run-with-idle-timer 300 t #'zone-if-not-fire-snow))

;; ########################################################################################

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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
