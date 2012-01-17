; Ben's .emacs version 2.0 
; Wed, Dec 21 2011  11:15
; A refactoring of my .emacs file                                    
; Perfection is an elusive, mythical creature that I have yet to catch.

; A word on formatting. Each section has a short description of what kind of 
; information is contained therein. By convention a line of comments should not
; exceed col 79.

;;;;;;;;;;;;;;;;;;
; Basic Settings ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This section contains basic settings controlling emacs. They typically do    ;
; not have any dependencies on 3rd party lisp functions, etc.                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Set text-mode as the default major mode
(setq-default major-mode 'text-mode)

; Add extension types 
(setq auto-mode-alist (cons '(".wsdl" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".xsd" . nxml-mode) auto-mode-alist))

; Replaces the audible bell with a visual flash
(setq visible-bell 1)

; Set the default directory (this may need to be changed based b/c of os)
(setq default-directory "/Users/ben.abernathy")

; Highlights the current line
(global-hl-line-mode 1)

; Forces no blinking cursor
(blink-cursor-mode 0)

; Forces the block cursor
(setq bar-cursor nil)

; Turn off the toolbar
(tool-bar-mode 0)

; Force the font lock mode to true, this will enable syntax highlighting
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

; Format the title bar and the icons
(setq frame-title-format '("%f [mode: %m]" ) ; "filename [mode]" in title bar
      icon-title-format '("emacs: %b"))      ; "emacs: buffername" in icon

; Display the time in the mode line
(display-time-mode 1)

; Force the line and column numbers in the bar
(line-number-mode 1)
(column-number-mode 1)

; Removes the ugly splash screen
(setq inhibit-splash-screen t)

; Indentation and tab handling
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

; Highlight matching parenthesis
(show-paren-mode 1)

; Backup file handling
(setq make-backup-files nil) ; do not create back up files

; Let your yes be yes and your no be no
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)

; Don't word wrap
(toggle-truncate-lines t)

;;;;;;;;;;;;;;;;;;;;;;;;;
; Third Party Functions ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Adds functionality provided by third party packages.                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Add the script directory
(add-to-list 'load-path "~/.elisp")

;; Enable SVN support
(require 'psvn)

;; For themes, I use the color-theme package.
;; http://www.nongnu.org/color-theme
;; http://www.emacswiki.org/emacs/ColorTheme
(add-to-list 'load-path "~/.elisp/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-charcoal-black))
  )
;; Select by M-x color-theme TAB RET
;; Or by M-x color-theme-select

; Loads the linum code (displays line numbers in the gutter)
; You must load this after you initialize the theme else the gutter numbers 
; will be funky colors.
(require 'linum)
(global-linum-mode 1)

; A simple little table editing mode that gives you a simple spreadsheet style 
; of editing. Tables can also be saved to HTML.
;(require 'table)
;(add-hook 'text-mode-hook 'table-recognize)

; A cool template capability
(load "~/.elisp/defaultcontent/defaultcontent.el")
(require 'defaultcontent)
(setq dc-auto-insert-directory "~/.elisp/defaultcontent/templates/")
(setq dc-fast-variable-handling t)

; Add templates here
(add-to-list 'dc-auto-insert-alist '("\\.cs$" . "template.cs"))
(add-to-list 'dc-auto-insert-alist '("\\.xsd$" . "template.xsd"))
(add-to-list 'dc-auto-insert-alist '("\\.java$" . "template.java"))

;(add-to-list 'load-path "~/.elisp")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.elisp/ac-dict")
(ac-config-default)



;;;;;;;;;;;;;;;;;;;;;;
; Personal Functions ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Functions that I wrote myself to solve some everyday problems. ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This function will insert a DTG at the point. Taken from a blog.
; Example: Mon, 17 Jun 96  12:52
(defun insert-timeofday ()
  "function to insert time of day at point.\n format: DayOfWeek, Month Date Year   24hrTime"
  (interactive)
  (let (localstring mytime)
    (setq localstring (current-time-string))
    (setq mytime (concat (substring localstring 0 3)  ;day-of-week
                         ", " 
                         (substring localstring 4 7)  ;month 
                         " "
                         (substring localstring 8 10) ;day number
                         " "
                         (substring localstring 20 24 ) ;4-digit year
                         "  "
                         (substring localstring 11 16 ) ;24-hr time
                         "\n"
                         ))
    (insert mytime))
) 


; Re-indents an entire buffer!
(defun indent-buffer () 
  "re-indents the entire buffer!"
  (interactive)
  (indent-region (point-min) (point-max)))


; The following functions are in development and may or may not work

;(defun c-block-comment (begin end)
;  "Create a c-style block comment around a region"
;  (interactive "*r")
;  (insert begin)
;  (insert end))

(defun c-line-comment ()
  "Create a c-style line comment at the current line"
  (interactive)
  (beginning-of-line)
  (insert "// "))


(defun color-bbsguru () 
  "When you want to relive yesterday. Yah buddy!"
  (interactive)
  (color-theme-initialize)
  (color-theme-renegade))

(defun color-programmer ()
  "When you need to easily read code."
  (interactive)
  (color-theme-initialize)
  (color-theme-eclipse))

(defun color-default () 
  "Changes the color back to what is normally used."
  (interactive)
  (color-theme-initialize)
  (color-theme-charcoal-black))

(defun psvm () 
  "Inserts a bare java main method."
  (interactive)
  (insert "public static void main(String...args) {\n\n\n}")
  (babernat-indent-buffer))

(defun tostring () 
  "Inserts a bare java toString method."
  (interactive)
  (insert "@Override public String toString() {\nreturn \"\";\n}")
  (babernat-indent-buffer))


(require 'server)
  (defun server-ensure-safe-dir (dir) "Noop" t) ; Suppress error "directory
                                                 ; ~/.emacs.d/server is unsafe"
                                                 ; on windows.
(server-start)
