(eval-when-compile
  (require 'color-theme))

(defun color-theme-programmer-friendly ()
  "My programmer friendly color theme."
  (interactive)
  (color-theme-install
   '(color-theme-programmer-friendly
     ((foreground-color . "black")
      (background-color . "white")
      (background-color . "white")
      (mouse-color . "sienna3")
      (cursor-color . "HotPink")
      (border-color . "Blue")
      (background-mode . light))
     (default ((t (nil))))
     (region ((t (:foreground "Gray75" :background "Black"))))
     (underline ((t (:foreground "yellow" :underline t))))
     (modeline ((t (:foreground "Gray75" :background "blue4"))))
     (modeline-buffer-id ((t (:foreground "Gray75" :background "firebrick"))))
     (modeline-mousable ((t (:foreground "Gray75" :background "green4"))))
      (background-color . "white")
      (mouse-color . "sienna3")
      (cursor-color . "HotPink")
      (border-color . "Blue"))))

(color-theme-programmer-friendly)

(provide 'color-theme-progammer-friendly)
