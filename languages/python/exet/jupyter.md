# jupyter 

change `\documentclass[11pt]{article}` to `\documentclass[11pt]{ctexart}` in file `nbconvert/templates/latex/article.tplx`

## nbconvert

jupyter nbconvert --to pdf --template=nbextensions example.ipynb
