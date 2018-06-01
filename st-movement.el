;;; redis-configs.el --- Sublime Text like word movement         -*- lexical-binding: t; -*-

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

;;; Code:

;; + variables

(defvar st-forward-re ".$\\|[\n]\\|\\W?[[:upper:]]*[[:digit:][:lower:]]+\\|\\W?[[:upper:]]+\\|[^[:word:][:space:]_\n]+")

(defvar st-backward-re "\n.\\|.\n\\|[[:space:][:word:]_\n][^\n[:space:][:word:]_]+\\|\\(\\W\\|[[:lower:]]\\)[[:upper:]]\\|\\W\\w+")

;;;###autoload
(defun st-subword-forward ()
  "Subword movement forward."
       (interactive)
       (let ((case-fold-search nil))
         (re-search-forward st-forward-re nil t))
       (goto-char (match-end 0)))

;;;###autoload
(defun st-subword-backward ()
  "Subword movement backward."
  (interactive)
  (let ((case-fold-search nil))
    (if (re-search-backward st-backward-re nil t)
        (goto-char (1+ (match-beginning 0))))))

;;;###autoload
(provide 'st-movement)
