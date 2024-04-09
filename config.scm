;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (gnu system nss)
	     (gnu services desktop)
	     (guix utils)
	     (ice-9 popen)
	     (ice-9 rdelim)
	     (ice-9 format))
(use-service-modules networking ssh authentication desktop dbus)
(use-package-modules certs shells)

(operating-system
  (locale "en_US.utf8")
  (timezone "America/Los_Angeles")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "miniguix")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "svitax")
                  (comment "svitax")
                  (group "users")
                  (home-directory "/home/svitax")
                  (supplementary-groups '("wheel" "netdev" "input" "kvm" "cdrom" "audio" "video" "tty")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (map specification->package+output
			 '(;"i3-wm"
			   ;"i3status"
			   ;"sway"
			   "nss-certs"
			   ;"emacs"
			   ;"dmenu"
			   ;"st"
			   "git"
			   "gnupg"
			   "curl"
			   "polkit"
			   "dbus"
			   "cryptsetup"
			   "rsync"
			   "openssl"
			   "libusb"
			   "dosfstools"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service dhcp-client-service-type)
		 (service accountsservice-service-type)
		 (service elogind-service-type)
		 ;; To configure OpenSSH, pass an 'openssh-configuration'
		 ;; record as a second argument to 'service' below.
		 (service openssh-service-type))
	   ;; This is the default list of services we
	   ;; are appending to.
	   %base-services))
  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/sda"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "e87c824d-b9b2-4920-9b2b-a31411abd956")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "2d13e44b-242a-4402-9c09-032b49e5560c"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
