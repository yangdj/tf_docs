# rmarkdown syntax

## headings

atx sytle:

* `#` level one
* `##` level two
* `###` level three
* `####` level four
* `#####` level five
* `######` level six

setext style:

* `===` level one
      
        level one header
        ===

* `---` level two

        level two header
        ---

## links

1. `(http://example.com)`
2. `[example](http://example.com)`
3. `[example][foo]` `[foo]: http://example.com "hover text"`
4. `![img](/path/to/img "optional title")`
5. `![img](foo)` `[foo]: path/to/img "optional title"`

## equations

block equations:

```
\begin{equation}
\label{eq-abc}
a + b = c
\end{equation}
```

the `\label{}` gives the equation a name, you can use it to refer to the equation, using `\ref{eq-abc}`, or `\autoref{eq-abc}`.

inline equations can be added by writing dollar signs around an equation: `$a + b = c$`

## figures

use `![figure caption](figure-name.jpg)` to include a figure. set `fig_caption: yes` to make sure a caption shows up underneath the figure which is turned off by default. and `![figure caption \label{figure-label}](figure-name.jpg)` give a label to a figure. use `\ref{figure-label}` or `\autoref{figure-label}` to refer to the figure.

## tables

## R code

inline r code: `` `r
1+1` ``.

block r code:

    ```{r chunk-name}`r ''`
    plot(pressure)
    ```

## latex syntax

* `\label{label-name}`: sets a lable
* `\ref{label-name}` or `\autoref{label-name}`: refers to a lable
* `\newpage`: starts on a new page
* `\tableofcontents`: show table of contents
* `\setcounter{tocdepth}{2}`: set toc depth to `2` or other depth
* `\listoffigures`
* `\listoftables`
* `\FloatBarrier`: keep figures, tables and so on display in its own chapter

## others

1. when print a code chunk as is, for block r code, indent four spaces, and refer to this source file.
