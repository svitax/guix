(setq inhibit-defaults? #t
      border-px 3
      border-color "#fbf7f0"
      focus-color "#9fc6ff"
      root-color "#efe9dd"
      smart-gaps? #t
      smart-borders? #t
      gaps-oh 12
      gaps-ov 12
      gaps-ih 12
      gaps-iv 12)

(dwl:start-repl-server)

(dwl:set-tty-keys "C-M")
(dwl:set-tag-keys "s" "s-S")

(set-rules '((id . "foot")
	     (terminal? . #t))
	   '((id . "emacs")
	     (alpha . 1.0)
	     (swallow? . #t))
	   '((id . "mpv")
	     (alpha . 1.0)
	     (swallow? . $t))
	   '((id . "imv")
	     (alpha . 1.0)
	     (swallow? . #t)))

(set-keys "s-d" '(dwl:spawn "bemenu-run")
	  "s-<return>" '(dwl:spawn "footclient")
	  "s-e" '(dwl:spawn "emacsclient" "-c")
	  "s-j" '(dwl:focus-stack 1)
	  "s-k" '(dwl:focus-stack -1)
	  "s-c" 'dwl:kill-client
	  "S-s-q" 'dwl:quit
	  "s-f" 'dwl:toggle-fullscreen
	  "<XF86AudioRaiseVolume>" '(dwl:spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "+5%")
	  "<XF86AudioLowerVolume>" '(dwl:spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "-5%")
	  "<XF86AudioMute>" '(dwl:spawn "pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle"))

(add-hook! dwl:hook-startup
	   (lambda ()
	     (dwl:shcmd "foot" "--server")
	     (dwl:shcmd "emacs" "--fg-daemon")
	     (dwl:spawn "kanshi")))
