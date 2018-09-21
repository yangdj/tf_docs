# python packages

1. for database:

* `psycopg2-binary` - postgresql
* `mysqlclient` - mysql
* `pymssql` - sqlserver
* `pyhive[hive]` - hive
* `pgcli` - `command line tool for postgresql`
* `mycli` - `command line tool for mysql`

to install `pymssql`, you may have to:

    yum install freetds-devel # for sqlfont.h maybe need export C_INCLUDE_PATH=/usr/include (or other path for head files)
    yum install unixODBC-devel # for sql.h
    pip install pymssql
    prefix - mssql+pymssq

to install `pyhive[hive]`, you may have to:

    yum install cyrus-sasl-devel
    yum install cyrus-sasl-plain

2. data processing:

* `line_profiler`
* `ipython`
* `numpy`
* `pandas`
* `matplotlib`
* `scipy`
* `scikit-learn`
* `jupyter`
* `jupyter_contrib_nbextensions`
* `ipython-sql`

3. others:

* `binarytree`
* `django-uuslug` - unique unicode slug, `from uuslug import slugify, uuslug`
* `Pillow` - image process, and for django's `ImageField`
