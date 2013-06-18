;;; begin myfuncs.el

;;;;;;;;;;;;;;;;;;;;;;
; Personal Functions ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Functions that I wrote myself to solve some everyday problems. ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
; Mon, Jun 17 2013  19:54                                                      ;
; File creation, migration of fcns from .emacs to this file.                   ;
;                                                                              ;
; ---------------------------------------------------------------------------- ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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

(defun c-block-comment ()
  "Create a c-style block comment around a region"
  (interactive)
  (setq rstart (region-beginning))
  (setq rstop (region-end))
  (goto-char rstart)
  (insert "/*  ")
  (goto-char rstop)
  (forward-char 4)
  (insert "  */")
  (goto-char rstart))

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


;;; end of myfuncs.el
