# knitr

global setting:

```r
{r setup, include=FALSE}
  knitr::opts_chunk$set(echo = FALSE, warning = FALSE, message = FALSE, fig.showtext = TRUE)
```

parameters:

* `comment="#"` - set comment string for the output
* `warning = FALSE` - hide warnings
* `message = FALSE` - hide messages
* `echo = FALSE` - hide r source code
* `eval = FALSE` - not evaluate code
* `resutls = "hide"` - hide text output
* `include = FALSE` - hide everything, the code is evaluated
* `fig.path="figs/"`
* `fig.width = 12`
* `fig.height = 8`
* `fig.cap = "figure caption. \\label{figurelabel}"`
* `child = "child.rmd"` - include other rmd file
