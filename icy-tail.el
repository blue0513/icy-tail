;;; icy-tail.el --- tail -n file in Emacs

;;; Commentary:
;; Add the following to your Emacs init file:
;;
;; (require 'icy-tail)
;;
;; This code is greatly respecting
;; https://www.emacswiki.org/emacs/tail.el

;;; Code:

(defgroup icy-tail nil
  "tail -n file in Emacs"
  :prefix "icy-"
  :group 'icy-tail
  )

(defun icy-tail-buffer(tail-buffer tail-msg)
  (if (window-minibuffer-p)
      (other-frame -1))
  (let* ((icy-tail-buf (set-buffer (get-buffer-create tail-buffer))))
    (insert tail-msg)
    (switch-to-buffer icy-tail-buf)
    ))

(defun icy-tail-filter (process line)
  (icy-tail-buffer (process-buffer process) line))

(defun icy-tail-command (command &rest args)
  (interactive "sTail command: \neToto: ")
  (let ((process
	 (apply 'start-process-shell-command
		command
		(concat "*Tail: "
			command
			(if args " " "")
			(mapconcat 'identity args " ")
			"*")
		command
		args)))
    (set-process-filter process 'icy-tail-filter)))

;;;###autoload
(defun icy-tail-file (file)
  (interactive "Ftail file: ")
  (icy-tail-command "tail" "-n 100" file))

(provide 'icy-tail)

;;; icy-tail.el ends here
