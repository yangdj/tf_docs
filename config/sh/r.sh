#! /usr/bin/env bash

install_one_rpkg() {
    sudo su - -c "R -e \"install.packages('\"$1\"', repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN/')\""
}

install_rpkgs() {
    sudo yum install libpng-devel perl-Digest-MD5

    install_one_rpkg tidyverse
    install_one_rpkg plotly
    install_one_rpkg devtools
    install_one_rpkg rmarkdown
    install_one_rpkg shiny
    install_one_rpkg kableExtra
    install_one_rpkg arules
    install_one_rpkg arulesViz
    install_one_rpkg DiagrammeR
    install_one_rpkg DiagrammeRsvg
    install_one_rpkg nycflights13
    install_one_rpkg xaringan
    install_one_rpkg miniUI
    install_one_rpkg config
    install_one_rpkg rpart.plot

    sudo yum install cairo-devel pango-devel libXt-devel
    install_one_rpkg Cairo

    install_one_rpkg pool
    install_one_rpkg odbc
    sudo yum install unixODBC-devel
    sudo yum install postgresql-odbc

    yum install postgresql-devel
    install_one_rpkg RPostgres

    sudo yum install MariaDB-devel
    # then
    sudo ln -s /usr/lib64/libmariadbclient.a /usr/lib64/libmariadb.a
    # or wget https://downloads.mariadb.com/Connectors/c/connector-c-${some-version}

    install_one_rpkg RMariaDB
    install_one_rpkg RSQLite

    install_one_rpkg FactoMineR
    install_one_rpkg factoextra
    install_one_rpkg rpivotTable
    install_one_rpkg XLConnect
    install_one_rpkg roxygen2
    install_one_rpkg testthat
    install_one_rpkg data.table
    install_one_rpkg pivottabler
    install_one_rpkg pryr
    install_one_rpkg influxdbr
    install_one_rpkg future
    install_one_rpkg maps
    install_one_rpkg ggthemes
    install_one_rpkg sparklyr
    install_one_rpkg ggraph
    install_one_rpkg tidyraph
    install_one_rpkg ggdag
    install_one_rpkg svgPanZoom
    install_one_rpkg bookdown
    install_one_rpkg rsvg
    install_one_rpkg webshot
    install_one_rpkg bench
}
