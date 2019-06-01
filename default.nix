with import <nixpkgs> {};

let css = fetchurl {
            url = "https://gongzhitaao.org/orgcss/org.css";
            sha256 = "089ng30fskkv9j6aqakffcrmgibidg778jfdgjsfk6s1lg14yc49";
          }; in

runCommand "raptorjit-patterns-manual" { buildInputs = [ emacs ]; } ''
  cp ${./raptorjit-patterns.org} raptorjit-patterns.org
  emacs -Q --batch --eval "
    (progn
      (require 'ox-html)
      (with-current-buffer (find-file-noselect \"raptorjit-patterns.org\")
        (org-html-export-to-html)))"
  install -D raptorjit-patterns.html $out/raptorjit-patterns.html
  install ${css} $out/org.css
''

