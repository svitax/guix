;; This is an operating system configuration generated
;; by the graphical installer
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu) (nongnu packages linux))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
  (local "en_US.utf8")
  (timezone "America/Los_Angeles")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "svitax")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "svitax")
                  (comment "svitax")
                  (group "users")
                  (home-directory "/home/svitax")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  ;; Packages installed system-wide. Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "emacs")
                          (specification->package "emacs-exwm")
                          (specification->package "emacs-desktop-environment")
                          (specification->package "nss-certs"))
                    %base-packages))

  ;; Below is the list of system services. To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal
  (services
    (append (list (service gnome-desktop-service-type)
                  (set-xorg-configuration
                    (xorg-configuration (keyboard-layout keyboard-layout))))
            ;; This is the default list of services we
            ;; are appending to.
            %desktop-services))
  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/sda"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                  "2697040e-165c-4bda-b733-e65e262c7a25")))))

  ;; The list of file systems that get "mounted". The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                   "3096f071-1087-468f-938e-2f92756c7e17"
                                   'ext4))
                         (type "ext4")) %base-file-systems)))
