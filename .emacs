;;;;;;;;;;
; Header ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ben.abernathy's .emacs                                                       ;
;                                                                              ;
; My living, breathing .emacs                                                  ;
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
;                                                                              ;
; Fri, Nov 15 2013  13:11                                                      ;
; Cleanup, added nav and enabled semantic.                                     ;
;                                                                              ;
; ---------------------------------------------------------------------------- ;
;                                                                              ;
; Mon, Jun 17 2013  20:46                                                      ;
; Added markdown-mode, migrated fuctions to myfuncs.el                         ;
;                                                                              ;
; ---------------------------------------------------------------------------- ;
;                                                                              ;
; Mon, Jun 17 2013  16:36                                                      ;
; Major clean up and implementation of some new fcns. Start of change log.     ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;
; Basic Settings ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This section contains basic settings controlling emacs. They typically do    ;
; not have any dependencies on 3rd party lisp functions, etc.                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Load personal functions
(load "~/.elisp/myfuncs.el")

; Set text-mode as the default major mode
(setq-default major-mode 'text-mode)

; Add extension types 
(setq auto-mode-alist (cons '(".wsdl" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".xsd" . nxml-mode) auto-mode-alist))

; Replaces the audible bell with a visual flash
(setq visible-bell 1)

; Set the default directory (this may need to be changed based b/c of os)
(setq default-directory 
      (if (getenv "HOME") (getenv "HOME") "/Users/ben.abernathy"))

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
(setq make-backup-files nil) ; do not create backup files

; Let your yes be yes and your no be no
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)

; Don't word wrap
;(toggle-truncate-lines t)

; This handles loaded buffers with the same name
; The reverse means that the name is first followed by the directory.
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

; Add Git support
(add-to-list 'load-path "~/.elisp/git")
(require 'git)
(require 'git-blame)

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

; Org mode!!!
(setq load-path (cons "~/.elisp/org-7.8.03/lisp" load-path))
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

; Mark it down, way down.
(require 'markdown-mode)
;autoload 'markdown-mode "markdown-mode"
;   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

; Saves the previous layout
(desktop-save-mode 1)


; Starts with a new junk buffer
(add-hook 'after-init-hook 
          '(lambda () 
          (switch-to-buffer 
          (get-buffer-create "*junk*"))))

; Semantic setup for IDE-like behavior
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
 
(semantic-mode 1)

(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)

; A simple directory/source navigation tool 
(add-to-list 'load-path "~/.elisp/emacs-nav-49")
(require 'nav)
(nav-disable-overeager-window-splitting)
;; Optional: set up a quick key to toggle nav
(global-set-key [f8] 'nav-toggle)
