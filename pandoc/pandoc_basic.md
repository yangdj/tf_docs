# pandoc usage

## tlmgr

* sudo tlmgr update --self --all
* sudo tlmgr install collectbox (for collectbox.sty)

##  commands

usage: 

    pandoc test.md --pdf-engine=xelatex  -V mainfont="STSong" --template=template.tex -s -o test.pdf

    pandoc --list-input-formats
    pandoc --list-output-formats

`pandoc` use `utf-8` encoding for both input and output, if not, you can use `iconv`:

    iconv -t utf-8 input.txt | pandoc | iconv -f utf-8

options:

* `-f --from=FORMAT -t --to=FORMAT`
    * markdown -> .md
    * markdown_strict -> .md
    * html -> .html
    * latex -> .tex
    * docx -> .docx
    * pdf  -> .pdf
    * -> revealjs
* `-o --output=FILE`
* `--template=FILE` - `pandoc -D latex > template.tex` get the default latex template.
* `-s --standalone` - with a header and footer, not just a fragment
* `--pdf-engine=xelatex` - for pdf
* `-V --variable=key`
    * mainfont=STSong
    * pagetitle=your-title
* `--mathml` - convert tex math into mathml type
* `--list-input-formats`
* `--list-output-formats`
* `--self-contained`
* `-c url --css=url`
* `--toc --table-of-contents`
* `--toc-depth=number`

for `pdf` output, you'll need to have `LaTeX` installed:

* MacTex on OS X
* MikTeX on Windows
* texlive on Linux

and install some fonts, e.g., `STSong` for `centos`:
