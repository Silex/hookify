;;; hookify.el --- Interactive commands to create temporary hooks

;; Author: Philippe Vaucher <philippe.vaucher@gmail.com>
;; URL: https://github.com/Silex/hookify
;; Keywords: hook, convenience
;; Version: 0.0.1
;; Package-Requires: ((s "1.9.0") (dash "1.5.0"))

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; This library provides interactive commands to create temporary hooks
;;
;;; Code:

(require 's)
(require 'dash)

(defun is-hook-p (symbol)
  "Returns t if SYMBOL is a hook."
  (and (boundp symbol)
       (s-ends-with? "-hook" (symbol-name symbol))))

;;;###autoload
(defun hookify (hook function)
  "Append FUNCTION to HOOK."
  (interactive
   (list (intern (completing-read "hook: " obarray 'is-hook-p t))
         (let ((minibuffer-completing-symbol t))
           (read-from-minibuffer "function: " nil read-expression-map t 'read-expression-history))))
  (add-hook hook `(lambda () ,function) nil t))

;;;###autoload
(defun unhookify (hook function)
  "Remove FUNCTION from HOOK."
  (interactive
   (list (intern (completing-read "hook: " obarray 'is-hook-p t))
         (let ((minibuffer-completing-symbol t))
           (read-from-minibuffer "function: " nil read-expression-map t 'read-expression-history))))
  (remove-hook hook `(lambda () ,function) t))

(provide 'hookify)

;;; hookify.el ends here
