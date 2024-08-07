;;; bun-mode.el --- bun-mode                         -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Ricky Anderson

;; Author: Ricky Anderson <randerson@thinky>
;; Keywords: languages

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'yarn-mode)

;;;###autoload
(define-derived-mode bun-mode yarn-mode "Bun"
  "Simple mode to highlight bun.lockb files."
  :syntax-table yarn-mode-syntax-table
  (beginning-of-buffer)
  (when (looking-at-p "#!/usr/bin/env bun")
	(let* ((bun-cmd (format "bun %s" (shell-quote-argument (buffer-file-name))))
		   (content (shell-command-to-string bun-cmd)))
	  (erase-buffer)
	  (insert content)))
  (setq font-lock-defaults '(yarn-mode-font-lock-defaults))
  (setq buffer-read-only t)
  (set-buffer-modified-p nil))

;;;###autoload
(add-to-list 'auto-mode-alist '("bun\\.lockb\\'" . bun-mode))

(provide 'bun-mode)
;;; bun-mode.el ends here
