(list (channel
       (name 'guix)
       (url "https://git.savannah.gnu.org/git/guix.git")
       (branch "master")
       (introduction
	(make-channel-introduction
	 "9edb3f66fd807b096b48283debdcddccfea34bad"
	 (openpgp-fingerprint
	  "BBB0 2DDF 2CEA F6A8 0D1D E643 A2A0 6DF2 A33A 54FA"))))
      (channel
       (name 'home-service-dwl-guile)
       (url "https://github.com/engstrand-config/home-service-dwl-guile")
       (branch "main")
       (introduction
	(make-channel-introduction
	 "314453a87634d67e914cfdf51d357638902dd9fe"
	 (openpgp-fingerprint
          "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C"))))
      (channel
       (name 'home-service-dtao-guile)
       (url "https://github.com/engstrand-config/home-service-dtao-guile")
       (branch "main")
       (introduction
	(make-channel-introduction
	 "64d0b70c547095ddc840dd07424b9a46ccc2e64e"
	 (openpgp-fingerprint
          "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C")))))
