with import <nixpkgs> {};

let css = fetchurl {
            url = "https://gongzhitaao.org/orgcss/org.css";
            sha256 = "089ng30fskkv9j6aqakffcrmgibidg778jfdgjsfk6s1lg14yc49";
          }; in

runCommand "raptorjit-optimization-manual" { buildInputs = [ emacs ]; } ''
  cp ${./raptorjit-optimization.org} raptorjit-optimization.org
  emacs -Q --batch --eval "
    (progn
      (require 'ox-html)
      (with-current-buffer (find-file-noselect \"raptorjit-optimization.org\")
        (org-html-export-to-html)))"
  install -D raptorjit-optimization.html $out/raptorjit-optimization.html
  install ${css} $out/org.css
''

