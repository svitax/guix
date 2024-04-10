;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu packages gcc)
             (gnu packages wm)
             (gnu packages freedesktop)
             (gnu packages xdisorg)
             (gnu packages datastructures)
             (gnu packages pulseaudio)
             (gnu services)
             (gnu home services)
             (gnu home services desktop)
             (gnu home services shells)
             (gnu home services sound)
             (gnu home services ssh)
             (guix packages)
             (guix download)
             (guix git-download)
             (guix gexp)
             (guix utils)
             (srfi srfi-1))

(define-public (alist->environment-variable var alist)
  (define (add-arg acc key value)
    (string-append acc " --" key
                   (if (not value) "" (string-append " " value))))
  ;; Join arguments into a single string, with each key prefixed
  ;; with "--" and the key and value separated with a space.
  ;; Values that have no value (or #t) will only add the prefixed key.
  ;; If the value is #f, the key will not be included at all.
  (define str
    (fold
     (lambda (arg acc)
       (let ((key (car arg)) (value (cdr arg)))
         (cond
          ((string? value) (add-arg acc key (string-append "'" value "'")))
          ((number? value) (add-arg acc key (number->string value)))
          ((eq? value #t) (add-arg acc key #f))
          (else acc))))
     "" alist))
  ;; Return an alist containing the environment variable name VAR
  ;; and its value as the result of serializing ALIST
  `((,var . ,str)))

;; TODO: dwl patches need to be altered to work with dwl-guile:
;; tab (pango & cairo deps.), pertag, namedscratchpads, alwayscenter,
;; zoomswap, rotatetags, movecenter, moveresizekb, shiftview, bottomstack,
;; swapandfocusdir
;; (define dwl-guile-latest
;;   (let ((commit "3b9eb86637777a8f82211114a9c38d1c1ede03f7"))
;;     (package
;;      (inherit dwl-guile)
;;      (name "dwl-guile-latest")
;;      (version (string-append "2.0.0" "-" (string-take commit 8)))
;;      (source (origin
;;               (method git-fetch)
;;               (uri (git-reference
;;                     (url "https://github.com/engstrand-config/dwl-guile")
;;                     (commit commit)))
;;               (file-name (git-file-name name version))
;;               (sha256
;;                (base32
;;                 "1ji3ycr91snxwlvchrb2wy8piynxzmqzv1iyr4bdmsjcmh9jrjg4")))))))

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages (map specification->package+output
                '("icecat"
                  "qutebrowser"
                  "alacritty"
                  "emacs-pgtk"
                  "bemenu"
                  "foot"
                  "neofetch"
                  "wlr-randr"
                  "kanshi"
                  "wl-clipboard"
                  "swaybg"
                  "imv"
                  "pulseaudio"
                  "mpv"
		  "sway"		  
                  ;; for dwl-guile tab patch
                  "cairo"
                  "pango"
                  ;;
                  )))

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list
   (simple-service 'some-useful-env-vars-service
                   home-environment-variables-service-type
                   `(("TERM" . "xterm-256color")
                     ("COLORTERM" . "xterm-256color")
                     ("WLR_NO_HARDWARE_CURSORS" . "1")
                     ("WLR_RENDERER_ALLOW_SOFTWARE" . "0")))
   (simple-service 'dot-configs-service
                   home-files-service-type
                   `((".config/sway/config"
		      ,(local-file "files/sway/config" #:recursive? #t))
		     (".config/kanshi/config"
                      ,(local-file "files/kanshi/config" #:recursive? #t))
                     (".config/foot/foot.ini"
                      ,(local-file "files/foot/foot.ini" #:recursive? #t))
                     (".config/git/config"
                      ,(local-file "files/git/config" #:recursive? #t))))
   (service home-bash-service-type
            (home-bash-configuration
             (guix-defaults? #t)))
   (service home-pipewire-service-type)
   (service home-dbus-service-type)
   ;; (service home-openssh-service-type)
   ;; (service home-ssh-agent-service-type)
   (simple-service 'bemenu-options
                   home-environment-variables-service-type
                   (alist->environment-variable
                    "BEMENU_OPTS"
                    `(("line-height" . 29)
                      ("fn" . "monospace:size=16")
                      ("nb" . "#fbf7f0")
                      ("nf" . "#000000")
                      ("ab" . "#fbf7f0")
                      ("af" . "#000000")
                      ("tb" . "#fbf7f0")
                      ("tf" . "#a60000")
                      ("fb" . "#fbf7f0")
                      ("ff" . "#000000")
                      ("hb" . "#dfd5cf")
                      ("hf" . "#a60000")
                      ("cf" . "#000000")
                      ("hp" . 10)
                      ("cw" . 2))))
   ;; (service home-dwl-guile-service-type
   ;;          (home-dwl-guile-configuration
   ;;           (package
   ;;            (patch-dwl-guile-package dwl-guile-latest
   ;;                                     #:patches (list %patch-xwayland
   ;;                                                     %patch-swallow
   ;;                                                     %patch-movestack)))
   ;;           (native-qt? #t)
   ;;           (auto-start? #t)
   ;;           (config (list `((load ,(local-file "files/dwl-guile/init.scm")))))))
   ;; (service home-dtao-guile-service-type
   ;;          (home-dtao-guile-configuration
   ;;           (auto-start? #t)
   ;;           (config
   ;;            (dtao-config
   ;;             (font "monospace:size=16")
   ;;             (background-color "#fbf7f0ff")
   ;;             (border-color "#193668ff")
   ;;             (foreground-color "#000000ff")
   ;;             (padding-left 8)
   ;;             (padding-right 8)
   ;;             (padding-top 2)
   ;;             (padding-bottom 2)
   ;;             (exclusive? #t)
   ;;             (layer 'LAYER-BOTTOM)
   ;;             (bottom? #f)
   ;;             (height #f)
   ;;             (block-spacing 0)
   ;;             (modules '((ice-9 match)
   ;;                        (ice-9 popen)
   ;;                        (ice-9 rdelim)
   ;;                        (srfi srfi-1)))
   ;;             (left-blocks
   ;;              (append
   ;;               (map
   ;;                (lambda (tag)
   ;;                  (let ((str (string-append
   ;;                              "^p(8)" (number->string tag) "^p(8)"))
   ;;                        (index (- tag 1)))
   ;;                    (dtao-block
   ;;                     (interval 0)
   ;;                     (events? #t)
   ;;                     (click `(match button
   ;;                               (0 (dtao:view ,index))))
   ;;                     (render
   ;;                      `(cond
   ;;                        ((dtao:selected-tag? ,index)
   ;;                         ,(string-append "^bg(#9fc6ff)^fg(#000000)" str "^fg()^bg()"))
   ;;                        ((dtao:urgent-tag? ,index)
   ;;                         ,(string-append "^bg(#a60000)^fg(#ffffff)" str "^fg()^bg()"))
   ;;                        ((dtao:active-tag? ,index)
   ;;                         ,(string-append "^bg(#c9b9b0)^fg(#000000)" str "^fg()^bg()"))
   ;;                        (else ,str))))))
   ;;                (iota 5 1))
   ;;               (list
   ;;                (dtao-block
   ;;                 (events? #t)
   ;;                 (click `(dtao:next-layout))
   ;;                 (render `(string-append "^p(4)" (dtao:get-layout)))))))
   ;;             (center-blocks
   ;;              (list
   ;;               (dtao-block
   ;;                (events? #t)
   ;;                (render
   ;;                 `(let ((title (dtao:title)))
   ;;                    (if (> (string-length title) 80)
   ;;                        (string-append (substring title 0 80) "...")
   ;;                        title))))))
   ;;             (right-blocks
   ;;              (list
   ;;               (dtao-block
   ;;                (interval 1)
   ;;                (render
   ;;                 `(let* ((port (open-input-pipe
   ;;                                (string-append
   ;;                                 ,(file-append (@ (gnu packages pulseaudio) pamixer)
   ;;                                               "/bin/pamixer")
   ;;                                 " --get-volume-human")))
   ;;                         (str (read-line port)))
   ;;                    (close-pipe port)
   ;;                    (unless (eof-object? str)
   ;;                      (string-append "^p(4)VOL: " str "^p(8)"))))
   ;;                (click
   ;;                 `(match button
   ;;                    (0 (system
   ;;                        (string-append ,pamixer " --toggle-mute"))))))
   ;;               (dtao-block
   ;;                (interval 1)
   ;;                (render
   ;;                 `(strftime "%A, %d %b (w.%V) %T"
   ;;                            (localtime (current-time)))))))))))
   )))
