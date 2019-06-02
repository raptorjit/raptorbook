with import <nixpkgs> {};

let css = fetchurl {
            url = "https://gongzhitaao.org/orgcss/org.css";
            sha256 = "089ng30fskkv9j6aqakffcrmgibidg778jfdgjsfk6s1lg14yc49";
          }; in

runCommand "raptorjit-optimization-manual"
  { name = "raptorbook"; buildInputs = [ emacs ]; }
  ''
    cp ${./raptorjit-optimization.org} raptorjit-optimization.org
    cp ${css} org.css
    emacs -Q --batch --eval "
      (progn

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

        (message \"Loading ox-html\")
        (require 'ox-html)
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




