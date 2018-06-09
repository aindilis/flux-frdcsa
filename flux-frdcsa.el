(global-set-key "\C-cRvt" 'flux-frdcsa-load-template)
(global-set-key "\C-cRvr" 'flux-frdcsa-run-flux-frdcsa)

(setq flux-frdcsa-template-dir "data-git/capsules")

(defun flux-frdcsa-load-template (&optional cww)
 ""
 (interactive)
 (flux-frdcsa-get-CWW-template cww)
 (flux-frdcsa-load-windows flux-frdcsa-template-dir "pl"))

(defvar flux-frdcsa-homedir (concat frdcsa-minor-codebases "/flux-frdcsa"))

(defun flux-frdcsa-load-windows (dir type)
 ""
 (interactive)
 (delete-other-windows)
 (split-window-vertically)
 (split-window-horizontally)
 (ffap (concat flux-frdcsa-homedir "/" dir "/" flux-frdcsa-CWW ".d." type))
 (other-window 1)
 (ffap (concat flux-frdcsa-homedir "/" dir "/" flux-frdcsa-CWW ".p." type))
 (other-window 1)
 (shell)
 (end-of-buffer)
 (insert (concat "cd " flux-frdcsa-homedir))
 ;; (insert (concat "cd /var/lib/myfrdcsa/codebases/minor/dnfct-frdcsa/systems/dnf-contingent-20160811/DNFct_run/wrappers"))
 (comint-send-input)
 (split-window-horizontally)
 (other-window 1)
 ;; (ffap (concat flux-frdcsa-homedir "/" flux-frdcsa-world-dir "/todo"))
 ;; (ffap (concat flux-frdcsa-homedir "/Flux-Frdcsa/Federated/PSEx.pm"))
 ;; (ffap (concat flux-frdcsa-homedir "/Flux-Frdcsa/Util/Graph.pm"))
 (ffap "/var/lib/myfrdcsa/codebases/minor/flux-frdcsa/flux_frdcsa.pl")
 (other-window -1)
 (kmax-window-configuration-to-register-checking ?A t))

(defun flux-frdcsa-get-CWW-template (&optional entity)
 ""
 (interactive)
 (flux-frdcsa-get-CWW 'template entity))

(defun flux-frdcsa-get-CWW-world (&optional entity)
 ""
 (interactive)
 (flux-frdcsa-get-CWW 'world entity))

(defun flux-frdcsa-get-CWW (type &optional entity)
 ""
 (interactive)
 (let* ((lists
	 (list
	  (concat flux-frdcsa-homedir "/" (if (equal type 'template)
				      flux-frdcsa-template-dir
				      flux-frdcsa-world-dir))))
	(name-dir
	 (apply 'append
	  (mapcar
	   (lambda (dir)
	    (mapcar (lambda (name)
		     (string-match (concat dir "/\\(.*?\\)\\.d\\." (if (equal type 'template) "pl" "pl") "$") name)
		     (list (match-string 1 name) dir))
	     (kmax-grep-list-regexp (f-entries dir nil t) (concat "d." (if (equal type 'template) "pl" "pl") "$"))))
	   lists)))
	(tmp
	 (or entity
	  (completing-read "Entity: " name-dir)))
	(flux-frdcsa-CWW
	 (setq flux-frdcsa-CWW tmp)))
  flux-frdcsa-CWW))

(defun flux-frdcsa-run-flux-frdcsa ()
 ""
 (interactive)
 (flux-frdcsa-load-windows flux-frdcsa-template-dir "pl")
 (end-of-buffer)
 (insert (concat
	  "./flux-frdcsa " ;; flux-frdcsa-planner " "
	  flux-frdcsa-CWW))
 (comint-send-input))
