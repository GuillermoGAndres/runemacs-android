; Referencias

(setq user-full-name "Guillermo Andres")
(setq user-mail-address "memocampeon35@gmail.com")
;; Create a variable to indicate where emacs's configuration is installed
(setq EMACS_DIR "~/.emacs.d/")
;; Window frame title
(setq frame-title-format '("Emacs" emacs-version "     %b   %*"))
;; (setq frame-title-format '("Emacs " emacs-version))

;; Scroll one line at a time
(setq scroll-step 1)

;---------------------------Paquetes de Melpa--------------------------------
; install the melpa repository
(require 'package)
(setq package-archives '(                          
                         ("melpa"     . "http://melpa.org/packages/")
			             ("elpa" . "https://elpa.typefo.com/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
			             ("elpa gnu"       . "http://elpa.gnu.org/packages/")
			             ;;("org"       . "http://orgmode.org/elpa/")
                         ;;("marmalade" . "http://marmalade-repo.org/packages/")
 						 ))
(package-initialize)
;(package-refresh-contents) ; Actualiza los paquetes cada vez que entres.

; Use package, si no esta instalado lo instala automaticamente y si lo esta refresca los paquetes.
;; Bootstrap 'usepackage
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
;http://cachestocaches.com/2015/8/getting-started-use-package/
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

;----------------------------Mi configuracion--------------------------------------------------  
;; Ocultan menu bar, tool bar y scroll
;; La funcion fboundp nada dice si es nombre de la propiedad coincide con 'nombre que pusimos que entre.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Longer whitespace, otherwise syntax highlighting is limited to default column
(setq whitespace-line-column 1000) 
; Ajusta el parrafo del buffer scratch.
(setq initial-scratch-message "")

;; Enable soft-wrap
;; (global-visual-line-mode 1)

;; Maintain a list of recent files opened
;;(recentf-mode 1)            
;;(setq recentf-max-saved-items 50)

;; Move all the backup files to specific cache directory
;; This way you won't have annoying temporary files starting with ~(tilde) in each directory
;; Following setting will move temporary files to specific folders inside cache directory in EMACS_DIR

(setq user-cache-directory (concat EMACS_DIR "cache"))
(setq backup-directory-alist `(("." . ,(expand-file-name "backups" user-cache-directory)))
      url-history-file (expand-file-name "url/history" user-cache-directory)
      auto-save-list-file-prefix (expand-file-name "auto-save-list/.saves-" user-cache-directory)
      projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" user-cache-directory))

; Coding specific setting
;; Automatically add ending brackets and braces
;(electric-pair-mode 1)

; Tiempo de echo.
(setq echo-keystrokes 0.3)

(set-language-environment "UTF-8")

;I like having the clock. 
;(display-time-mode 1)

;Most programming languages I work with prefer spaces over tabs
(setq-default indent-tabs-mode nil)

;; Make sure tab-width is 4 and not 8
(setq-default tab-width 4)

;Let’s disable questions about theme loading while we’re at it.
(setq custom-safe-themes t)

; Con esto no envuelve las lineas
(setq-default truncate-lines t)
;M-x toggle-truncate-lines
;if your lines wrap hard at the right-hand edge of the window,
;M-x visual-line-mode

;Commet y descommet
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

;; Esta implementacion falla
;; (defun mark-all-line ()
;;   (interactive)
;;   (c-beginning-of-statement 1)
;;   ;;(move-beginning-of-line 1)
;;   (set-mark-command (push-mark))  
;;   (c-end-of-statement)
;;   ;;(move-end-of-line 1)
;;   )
;; Encontre una mejor implementacion
(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))

(global-set-key (kbd "C-c o") 'select-current-line)

;;Inicializ Emacs server para sea mas rapido abrir archivos desde la terminal
;;emacsclient file.java // By example
;;(server-start) ;Ya no sera necesario con el plugin zsh emacs.

;Control-Alt-n Encuentra su otro parentesis
;C-M-n forward-sexp or C-M right
;C-M-b backward-sexp or C-M left
;(global-set-key (kbd "<C-M-left>") 'forward-sexp)
;(global-set-key (kbd "C-c b") 'backward-sexp)

;Aumentar tamaño de letra, before config: 130
;(set-face-attribute 'default nil :height 140)

;Agregar numeros de lineas
;@reference: https://emacs.stackexchange.com/questions/278/how-do-i-display-line-numbers-in-emacs-not-in-the-mode-line
;;(add-hook 'prog-mode-hook 'linum-mode)

;@see: https://www.emacswiki.org/emacs/ShowParenMode
;Matches parentesis
(show-paren-mode 1)

;Ocultar tool bar 
;;(tool-bar-mode -1)
;;(menu-bar-mode -1) 
;Destacar la línea actual
;(global-hl-line-mode +1)
;Pava ver menu bar solo cuando es ejecutado windos-system (GUI)
;(if window-system
;    (menu-bar-mode 1)
; )

;Don't show intro
(setq inhibit-startup-message t)

;Better answer
(fset 'yes-or-no-p 'y-or-n-p)
; Enable autopair in all buffers
(electric-pair-mode) 

; Alias de C-g para quitar command.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;Refresf buffer
(global-set-key (kbd "<C-f5>") 'revert-buffer)
;Evoid confirmation
;(global-set-key [f5] (lambda () (interactive) (revert-buffer nil t)))

(global-set-key (kbd "C-x <C-left>")  'windmove-left)
(global-set-key (kbd "C-x <C-right>") 'windmove-right)
(global-set-key (kbd "C-x <C-up>")    'windmove-up)
(global-set-key (kbd "C-x <C-down>")  'windmove-down)
(global-set-key (kbd "C-c <C-right>") 'tab-next)
(global-set-key (kbd "C-c <C-left>") 'tab-previous)

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Ya existe un shorcut M-g g
;;(global-set-key (kbd "C-c C-g") 'goto-line)

(global-set-key (kbd "C-c c") 'compile)

(add-hook 'markdown-mode-hook  'visual-line-mode)
(add-hook 'text-mode-hook  'visual-line-mode)
(add-hook 'org-mode  'visual-line-mode)
;;(add-hook 'web-mode-hook  'visual-line-mode)


(global-set-key (kbd "C-M-:") 'eval-region)

;; Hace que cualquier seleccion pueda ser sobreescrito inmediatemente.
(delete-selection-mode 1)

;; http://whattheemacsd.com/
; Indenta y limpias las tabulaciones y espacios extras.
(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (untabify-buffer) ;; Convierte los tabs en espacios.
  (delete-trailing-whitespace) ;; Elimina los espacios extras del final
  (indent-buffer)) ;;Indenta el buffer

(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; Empiza una nueva linea arriba o abajo
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

;; S - Es la tecla shift (Uppercase)
;; s - Tecla windows (Lowercase)
(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)


;; SGML and html mode elimina e indenta las etiquetas sobrantes
;; after deleting a tag, indent properly
(defadvice sgml-delete-tag (after reindent activate)
  (indent-region (point-min) (point-max)))


;; Unir lineas , uno las lineas con salto de linea en una sola.
(global-set-key (kbd "M-j")
            (lambda ()
                  (interactive)
                  (join-line -1)))


;; Rota ventanas
(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

;;(global-set-key (kbd "<C-tab>") 'rotate-windows)
(global-set-key (kbd "<C-S-SPC>") 'rotate-windows)

;; Move more quickly arriba,abajo,derecha e izquierda.
(global-set-key (kbd "C-s-n")
                (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))

(global-set-key (kbd "C-s-p")
                (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-s-f")
                (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))

(global-set-key (kbd "C-s-b")
                (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))



;; Renombra el nombre de un archivo.
(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)


;; Remueve el archivo de tu disco.
(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

;; Choca con el comando de las macros
;(global-set-key (kbd "C-x C-k") 'delete-current-buffer-file)
(global-set-key (kbd "M-s-k") 'delete-current-buffer-file)

;; Mueve una liena arriba o abajo.
(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)
    (previous-line)
    (previous-line)))


;; (global-set-key (kbd "<C-s-down>") 'move-line-down)
;; (global-set-key (kbd "<C-s-up>") 'move-line-up)
(global-set-key (kbd "<M-down>") 'move-line-down)
(global-set-key (kbd "<M-up>") 'move-line-up)


;; Mata la primera vez shell y la segunda eliminate buffer
;; Para que funcion C-d para kill terminal
(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map
              (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))


;; Refresa y actualiza, ya no tendras que presiona g cada vez que crees un archivo o lo modifiques.
;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)



;; Snippeta para aparecer los numeros de lineas solo cuando vayas con la funcion goto-line
;; Funciona bien si te gusta la configuracion sin numeros de lineas y solo las quieres ver cuando
;; tienes que ir a una de ellas.
;; (linum-mode -1) Funcion que desactivas los numeros de lineas.
;; --------------------------------------------------

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

;; (global-set-key [remap goto-line] 'goto-line-with-feedback)

;; --------------------------------------------------

;; Eliminar pares de parentersis, con la funcion integrada de emacs delete-pair
;; Debe colocarse al inicio del parentesis
;(global-set-key (kbd "M-p") 'delete-pair)
(global-set-key (kbd "M-s-p") 'delete-pair)

;; S - Es la tecla shift (Uppercase)
;; s - Tecla windows (Lowercase)
;; Copiar linea completa alias como yank-whole-line
(defun copy-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (move-beginning-of-line 1)
  ;(open-line 1)
  ;(next-line 1)
  ;(yank)
  )
(defun kill-all-line()
  "Kill all the line at beginning until end."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (kill-line) 
  ;; (move-beginning-of-line 1)
  (c-end-of-statement)
  (c-beginning-of-statement 1)
  ;(next-line 1)
  )

;; Pega linea completa
(defun paste-line ()
  (interactive)
  (move-beginning-of-line 1)
  (open-line-below)
  (move-beginning-of-line 1)
  (clipboard-yank)
  (move-beginning-of-line 1)
  )

(global-set-key (kbd "C-S-k") 'copy-line)
(global-set-key (kbd "C-S-p") 'paste-line)
(global-set-key (kbd "C-k") 'kill-all-line)
(global-set-key (kbd "s-k") 'kill-line)
;; C-M-k kill-sexp

;; Narrowing - escribir en una seccion en particular
;;C-x n n  (narrow-to-region)

;Enable or disable lines number
(global-set-key [f9] 'linum-mode)
;; Enable or disable display-line-numbers-mode
(global-set-key [C-f9] 'display-line-numbers-mode)


;; Save un buffer preguntando con permisos sudo (Muy usado con archivos en php que ser guardan en /opt/lampp/htdocs)
;; If the current buffer is not writable, ask if it should be saved with sudo.
;; https://github.com/munen/emacs.d/#sudo-save
(defun ph/sudo-file-name (filename)
  "Prepend '/sudo:root@`system-name`:' to FILENAME if appropriate.
This is, when it doesn't already have a sudo-prefix."
  (if (not (or (string-prefix-p "/sudo:root@localhost:"
                                filename)
               (string-prefix-p (format "/sudo:root@%s:" system-name)
                                filename)))
      (format "/sudo:root@%s:%s" system-name filename)
    filename))

(defun ph/sudo-save-buffer ()
  "Save FILENAME with sudo if the user approves."
  (interactive)
  (when buffer-file-name
    (let ((file (ph/sudo-file-name buffer-file-name)))
      (if (yes-or-no-p (format "Save file as %s ? " file))
          (write-file file)))))

(advice-add 'save-buffer :around
            '(lambda (fn &rest args)
               (when (or (not (buffer-file-name))
                         (not (buffer-modified-p))
                         (file-writable-p (buffer-file-name))
                         (not (ph/sudo-save-buffer)))
                 (call-interactively fn args))))


;; Toma screenshot de todo el frame
;; https://www.reddit.com/r/emacs/comments/idz35e/emacs_27_can_take_svg_screenshots_of_itself/
(defun screenshot-svg ()
  "Save a screenshot of the current frame as an SVG image.
Saves to a temp file and puts the filename in the kill ring."
  (interactive)
  (let* ((filename (make-temp-file "Emacs" nil ".svg"))
         (data (x-export-frames nil 'svg)))
    (with-temp-file filename
      (insert data))
    (kill-new filename)
    (message filename)))

;; Search the init file emacs
(defun initFileEmacs()
  (interactive)
  (find-file "~/.emacs.d/initFileEmacs"))


(defun my-kill-all-buffers ()
  "Kill all buffers"
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))

;;(global-set-key (kbd "C-x K") 'my-kill-all-buffers)

;; Adjusment paragrapg with C-q
(setq-default fill-column 80)

;; Trata de adivinar el default target directory, si hay alguna otra windows
;; elige esa localizacion, muy util para operacion de rename(que es lo mismo que
;; move) o copy.
(setq dired-dwim-target t)

;; Control+Shift {x, c, v}
(global-set-key (kbd "C-S-v") 'clipboard-yank)
(global-set-key (kbd "C-S-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-S-x") 'clipboard-kill-region)


(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (next-line arg))
(global-set-key (kbd "<C-s-down>") 'duplicate-line)

;----------------Notas-------------------------------------------------------------------------
; No se te olvide que cada vez que haces una configuracion o instalas un paquete , se configurara
; en el archivo pluginsuser/customFacesMe.el tienes que limpiarlo si cambias de tema, ya que se quedaran
; guardados las configuraciones del tema anterior, esto solo si tiene tiene informacion el archivo customFacesme.el


