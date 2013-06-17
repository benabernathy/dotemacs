;;;;;;;;;;
; Header ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ben.abernathy's .emacs                                                       ;
;                                                                              ;
; A refactoring of my .emacs file                                              ;
; Perfection is an elusive, mythical creature that I have yet to catch.        ;
;                                                                              ;
; A word on formatting. Each section has a short description of what kind of   ;
; information is contained therein. By convention a line of comments should    ;
; not exceed col 79.                                                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;
; License ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Copyright 2013 Benjamin Abernathy                                          ;
;                                                                              ;
;   Licensed under the Apache License, Version 2.0 (the "License");            ;
;   you may not use this file except in compliance with the License.           ;
;   You may obtain a copy of the License at                                    ;
;                                                                              ;
;       http://www.apache.org/licenses/LICENSE-2.0                             ;
;                                                                              ;
;   Unless required by applicable law or agreed to in writing, software        ;
;   distributed under the License is distributed on an "AS IS" BASIS,          ;
;   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   ;
;   See the License for the specific language governing permissions and        ;
;   limitations under the License.                                             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;
; Change Log ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mon, Jun 17 2013  16:36                                                      ;
; Major clean up and implementation of some new fcns. Start of change log.     ;
;                                                                              ;
; ---------------------------------------------------------------------------- ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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

; This handles loaded buffers with the same name
; The revers means that the name is first followed by the directory.
; For example, tmp/Mod.java and temp/Mod.java would be presented as:
; Mod.java\tmp and Mod.java\temp. This is nice because it doesn't
; mess with the buffer switching autocomplete.
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

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
     (color-theme-gruber-darker))
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
(add-to-list 'dc-auto-insert-alist '("\\.wsdl$" . "template.wsdl"))

; For auto completion within a buffer.
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.elisp/ac-dict")
(ac-config-default)


(setq load-path (cons "~/.elips/org-7.8.03/lisp" load-path))
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


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


; A shortcut for setting the color to a bbs-like color.
(defun color-bbsguru () 
  "When you want to relive yesterday. Yah buddy!"
  (interactive)
  (color-theme-initialize)
  (color-theme-renegade))

; A color that is more helpful for programming.
(defun color-programmer ()
  "When you need to easily read code."
  (interactive)
  (color-theme-initialize)
  (color-theme-eclipse))

; A shortcut for switching back to the default color.
(defun color-default () 
  "Changes the color back to what is normally used."
  (interactive)
  (color-theme-initialize)
  (color-theme-charcoal-black))

; Inserts a JDK 1.7 compatible public main entry method.
(defun java-psvm () 
  "Inserts a bare java main method."
  (interactive)
  (insert "public static void main(String...args) {\n\n\n}")
  (babernat-indent-buffer)) 

; Inserts a bare toString method.
(defun java-tostring () 
  "Inserts a bare java toString method."
  (interactive)
  (insert "@Override public String toString() {\nreturn \"\";\n}")
  (babernat-indent-buffer))

; Inserts a bare Java equals method.
(defun java-equals ()
  "Inserts a bare Java equals method."
  (interactive)
  (insert "@Override\n public boolean equals(Object o) {\nreturn false;\n}")
  (babernat-indent-buffer))

; Returns a new junk buffer.
(defun get-junk-buffer ()
  "Creates a new junk buffer as a scratch pad."
  (interactive)
  (switch-to-buffer
   (generate-new-buffer "*junk*")))

; Saves the previous layout
(desktop-save-mode 1)


; Starts with a new junk buffer
(add-hook 'after-init-hook 
          '(lambda () 
          (switch-to-buffer 
          (get-buffer-create "*junk*"))))

; (require 'server)
 ; (defun server-ensure-safe-dir (dir) "Noop" t) ; Suppress error "directory
                                                 ; ~/.emacs.d/server is unsafe"
                                                 ; on windows.
;(server-start)
