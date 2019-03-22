# YAML metadata

```yaml
---
title: "title"
subtitle: "subtitle"
author: "author"
date: "`r Sys.Date()`"
output: 
  pdf_document:
    fontsize: 12pt
    urlcolor: black
    linkcolor: black
    latex_engine: xelatex
    includes:
      in_header: tex/header.tex or ["a.file", "b.file", ...]
      before_body: doc-prefix.tex
      after_body: doc-suffix.tex
    highlight: tango
    fig_caption: true
    number_sections: true
    keep_tex: true
    template: template.tex
    toc: true
    toc_depth: 3
    df_print: kable
  html_document:
    toc: yes
    toc_depth: 3
    toc_float: true
    number_sections: true
    css: file.css
  word_document:
    reference_docx: ref.docx
---
```

elements:

* `in_header: [tex1.tex, tex2.tex]` - tex files for styling
* `urlcolor` - external link color
* `linkcolor` - internal link color
