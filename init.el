;; Initial configuration para ambos Linux and Windows
;; (setq custom-file "~/.emacs.d/initFileEmacs/customMeSettings.el")
;; (load custom-file)

;; eshell mode prompt
;;(load "~/.emacs.d/initFileEmacs/modes/mo-eshell.el")


; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
;; Con esto ya no sera necesarop poner :ensure t
(setq use-package-always-ensure t) 

;Better answer
(fset 'yes-or-no-p 'y-or-n-p)

;;Matches parentesis
(show-paren-mode 1)


;; Desactiva el mensaje de entrada de inicio
(setq inhibit-startup-screen t)

;; Hace que cualquier seleccion pueda ser sobreescrito inmediatemente.
(delete-selection-mode 1)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "C-x <C-left>")  'windmove-left)
(global-set-key (kbd "C-x <C-right>") 'windmove-right)
(global-set-key (kbd "C-x <C-up>")    'windmove-up)
(global-set-key (kbd "C-x <C-down>")  'windmove-down)
(global-set-key (kbd "C-c <C-right>") 'tab-next)
(global-set-key (kbd "C-c <C-left>") 'tab-previous)



(use-package company  
  :config
  (setq company-idle-delay 0.2)
  (setq company-show-numbers t)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-align-annotations t)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  :init
  (global-company-mode)
  :bind
  ;(("<C-return>" . company-complete))
  (("<C-M-return>" . company-complete)))


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))


;; ivy no instala counsel, se debe instalar a parte
(use-package ivy
  :diminish  
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill))
  :init
  (ivy-mode 1))
;; Use the :init keyword to execute code before a package is loaded.
;; Similarly, :config can be used to execute code after a package is loaded

;; Una vez instalado counsel, se puede instalar ivy-rich, ademas tambien instala swiper
;; Con M-o te da un menu de opciones en counse-M-x
(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; Funciona cuando es activado counsel-M-x fuction
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package magit
  :ensure t)

(global-set-key (kbd "C-M-k") 'counsel-switch-buffer)


(use-package yasnippet
    :ensure t
    :config
    (setq yas-snippet-dirs
          '(
            "./snippets"
            ))
    ;; Modo en general (Modo mayor)
    ;;(yas-global-mode 1)
    ;; Para un modo en expecifico (modo menor)
    (yas-reload-all)
    (add-hook 'c-mode-hook #'yas-minor-mode)
    (add-hook 'c++-mode-hook #'yas-minor-mode)
    (add-hook 'java-mode-hook #'yas-minor-mode)
    (add-hook 'org-mode-hook #'yas-minor-mode)
    (add-hook 'python-mode-hook #'yas-minor-mode)
    ;; (add-hook 'prog-mode-hook #'yas-minor-mode)  
    )

  (use-package multiple-cursors
     :ensure t
     :bind 
     (("C-c C-m" . mc/edit-lines))
     (("C->" . mc/mark-next-like-this))
     (("C-<" . mc/mark-previous-like-this))
     (("<M-S-down>" . mc/mark-next-like-this)) ;; no funciona bien con org mode
     (("<M-S-up>" . mc/mark-previous-like-this)) ;; por tambien active las de arriba
     (("C-S-l" . 'mc/mark-all-dwim))
     ;;(("C-c C-<" . 'mc/mark-all-like-this))
     ;;(("C-c C-a" . mc/skip-to-previous-like-this))
     (("C-M-}" . mc/skip-to-next-like-this))
     (("C-M-{" . mc/skip-to-previous-like-this))
     (("s-}" . mc/unmark-previous-like-this))
     (("s-{" . mc/unmark-next-like-this))
     ;;(("C-c C-M-{" . mc/mark-all-dwim))
     (("C-c C-M-}" . mc/mark-all-in-region))
     (("C-M-<mouse-1>" . mc/add-cursor-on-click))    
     (("C-c C-r" . mc/mark-sgml-tag-pair))
     )
