with import <nixpkgs> {};

let
  css = fetchurl {
          url = "https://raw.githubusercontent.com/gongzhitaao/orgcss/b1c9f8975dc2346b247910c861f0f4a193d63c68/docs/org.css";
          sha256 = "08la1404s339nvcpnspz2pf29c3bnp5lsmvfs5gdqp7sfzag9n07";
        };
  myEmacs = emacsWithPackages (epkgs: (with epkgs;
              [ use-package htmlize lua-mode org-ref ]));
in

runCommand "raptorjit-optimization-manual"
  { name = "raptorbook"; buildInputs = [ myEmacs ]; }
  ''
    cp ${./raptorjit-optimization.org} raptorjit-optimization.org
    cp ${css} org.css
    emacs -Q --batch --eval "
      (progn

        (setq debug-on-error t)
        (setq org-src-fontify-natively t)
        (require 'lua-mode)

	(defun my-org-inline-css-hook (exporter)
	  (when (eq exporter 'html)
	    (setq org-html-head-include-default-style nil)
	    (setq org-html-head (concat
				 \"<style type=\\\"text/css\\\">\n\"
				 \"<!--/*--><![CDATA[/*><!--*/\n\"
				 (with-temp-buffer
				   (insert-file-contents \"org.css\")
				   (buffer-string))
				 \"/*]]>*/-->\n\"
				 \"</style>\n\"))))

	(add-hook 'org-export-before-processing-hook 'my-org-inline-css-hook)

        (require 'use-package)
        (package-initialize 'noactivate)
        (use-package htmlize)
        (use-package lua-mode)
        (use-package org-ref)
        (message \"Loading ox-html\")
        (require 'ox-html)
        (message \"Loading htmlize\")
        (require 'htmlize)
	(message \"Opening org file\")
        (with-current-buffer (find-file-noselect \"raptorjit-optimization.org\")
	  (message \"Exporting HTML\")
          (org-html-export-to-html)
	  (message \"Done\")))"
    install -D raptorjit-optimization.html $out/raptorjit-optimization.html
    #install ${css} $out/org.css

    mkdir $out/nix-support
    echo "file HTML $out/raptorjit-optimization.html" >> $out/nix-support/hydra-build-products
  ''

