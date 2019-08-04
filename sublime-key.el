;;; sublime-key.el --- Sublime Text like word movement         -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Akash Hiremath

;; Author: Akash Hiremath <akashh246@gmail.com>
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; bind to word movement keys and enable subword-mode

;; TODO:
;;   1. Rewrite the regexp in a sane way.
;;   2. Currently forward-word does not handle square bracket.

;;; Code:

;; + variables

(defvar sublime-forward-re ".\n\\|\n.\\|\n\n\\|[ \t]*[^a-zA-Z0-9 \t\n>})]*[a-zA-Z0-9]+[^a-zA-Z0-9]\\|[ \t]*[^a-zA-Z0-9 \t\n>})]*[a-zA-Z0-9]*[>})].\\|[ \t]*[^a-zA-Z0-9 \t\n>})]+[^a-zA-Z0-9]")

(defvar sublime-backword-re "[\n.].\\|.\n\\|\n\n\\|[([{].+\\|.[<([{]\\|[^a-zA-Z0-9][a-zA-Z0-9]+[^a-zA-Z0-9 \t\n<{(]*[ \t]*\\|[ \t][a-zA-Z0-9]*[^a-zA-Z0-9 \t\n<{(]+[ \t]*\\|[[:space:]][^[[:space:]]]+")

;;;###autoload
(defun sublime-key-forward ()
  "Subword movement forward."
  (interactive)
  (let ((case-fold-search nil))
    (if (re-search-forward sublime-forward-re nil t)
        (goto-char (1- (match-end 0)))
      (progn
        (end-of-line)
        (point))))) ;; must return the current position

;;;###autoload
(defun sublime-key-backward ()
  "Subword movement backward."
  (interactive)
  (let ((case-fold-search nil))
    (if (re-search-backward sublime-backword-re nil t)
        (goto-char (1+ (match-beginning 0)))
      (progn
        (beginning-of-line)
        (point))))) ;; must return the current position

;;;###autoload
(defun sublime-key-forward-kill ()
  "Kill one word forward"
  (interactive "p")
  (kill-region (point) (sublime-key-forward)))

;;;###autoload
(defun sublime-key-backward-kill (_ignore)
  "Kill one word backward"
  (interactive "p")
  (kill-region (point) (sublime-key-backward)))

;;;###autoload
(provide 'sublime-key)
