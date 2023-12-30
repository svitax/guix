;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu home services)
             (gnu home services gnupg)
             (gnu home services shells)
             (gnu packages)
             (gnu packages gnupg)
             (gnu services)
             (guix gexp))

(primitive-load "home-alist.scm")

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
 (packages 
   (map (compose list specification->package+output)
	(list "neovim"
	      "btop"
	      "git"
	      "openssh"
	      "kitty")))
  
  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list 
     (service home-xdg-configuration-files-service-type
                 (home-alists-create-from-dirs
                  (list ".config/guix")))
     (service home-files-service-type
                 (list (list ".icons/default/index.theme"
                             (plain-file "gtk-waybar-needs"
                                         (string-append
                                          "[Icon Theme]" "\n"
                                          "Name=Default" "\n"
                                          "Inherits=Adwaita")))
                       (list ".guile"
                             (plain-file "guile-config"
                                         (string-append
                                          "(use-modules"
                                          " (ice-9 readline)"
                                          " (ice-9 colorized))"
                                          "(activate-readline)"
                                          "(activate-colorized)")))))
     (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '(("grep" . "grep --color=auto")
			      ("ll" . "ls -l")
                              ("ls" . "ls -p --color=auto")
			      ("lla" . "ls -lap --color=auto")
			      ("gup" . "guix pull && guix upgrade")
			      ("ghr" . "guix home reconfigure")
			      ("gsr" . "sudo guix system reconfigure")
			      ("gud" . "guix system delete-generations")))
                   (bashrc 
		     (list (local-file 
			     "/home/svitax/guix-config/.config/.bashrc"
			     "bashrc")))
                   (bash-profile 
		     (list (local-file 
			     "/home/svitax/guix-config/.config/.bash_profile"
			     "bash_profile"))))))))
