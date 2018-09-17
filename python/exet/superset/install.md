# superset installation for `superset`

## prepare

* `python3 -m venv ss` - create new virtual environment for superset named *ss*
* `pip3 install --upgrade setuptools pip` - update `pip` and `setuptools`
* `pip3 install superset` - install superset
* `fabmanager create-admin --app superset` - create an admin user
* `superset db upgrade` - initialize the database
* `superset load_examples` - load some data to play with
* `superset init` - create default roles and permissions
* `superset runserver` - start the webserver, to start a development webserver, use the `-d` option
* `kill pid(from superset runserver)` - shutdown the webserver

may be you have to `yum install cyrus-sasl-devel` when meets `sasl.h file not found`.

## customer configuration

### meta data storing

download packages for database connection:

    `pip3 install psycopg2 mysqlclient`

create configuration file `superset_config.py`, and make sure the file is under the `PYTHONPATH` path

    export PYTHONPATH=directory-including-superset_config.py:$PYTHONPATH

set `SQLALCHEMY_DATABASE_URI` to your own database path. you can also set `SECRET_KEY` to you own selected value.

**note:** when using `postgresql`, execution `superset db upgrade` may be blocked while creating tables, you can kill the idle connection process, then works proceed. you can directly find the `pid` in the database by exuecuting:

    select * from pg_stat_activity where datname ='your-database-name'
    select pg_terminate_backend(PID)

or use `ps` command, and `kill`.

### select languages to zh

modify configuration file `config.py` under `superset` package. set  `BABEL_DEFAULT_LOCALE = 'zh'`, and uncommment `zh` in the `LANUGAGES`, and comment other languages.

enter `superset` package directory, make directory:

    mkdir -p translations/zh/LC_MESSAGES

download `mo` file:

    wget https://github.com/airbnb/superset/raw/0.15.1/superset/translations/zh/LC_MESSAGES/messages.mo

or download respecitive `messages.po` file, and edit it according to your own need, then compile it to `.mo` file:

    msgfmt messages.po -o messages.mo

## data source

database address: `prefix://username:password@ipaddress:port/databasename?(parameter=value)`

### postgresql

    pip install psycopg2

    prefix - postgresql+psycopg2

maybe have to edit `extras.py` under `psycopg2` directory to avoid connection error:

    typarray = conn.server_version >= 80300 and "typarray" or "NULL"

you can change `80300` to greater value, e.g., `80400`.

maybe have to edit `SQL_NUM` variable in `sqlalchemy/dialects/postgresql/base.py` file, not to `left join pg_catelog.pg_enum` if `pg_catelog.pg_enum` is not available:

    SQL_ENUMS = """
          SELECT t.typname as "name",
            -- no enum defaults in 8.4 at least
            -- t.typdefault as "default",
            pg_catalog.pg_type_is_visible(t.oid) as "visible",
            n.nspname as "schema",
            e.enumlabel as "label"
          FROM pg_catalog.pg_type t
          LEFT JOIN pg_catalog.pg_namespace n ON n.oid = t.typnamespace
          LEFT JOIN pg_catalog.pg_enum e ON t.oid = e.enumtypid
          WHERE t.typtype = 'e'
     """

     SQL_ENUMS += 'ORDER BY "schema", "name", e.oid'

    SQL_ENUMS = """
          SELECT t.typname as "name",
            -- no enum defaults in 8.4 at least
            -- t.typdefault as "default",
            pg_catalog.pg_type_is_visible(t.oid) as "visible",
            n.nspname as "schema",
            -- e.enumlabel as "label"
            null as label
          FROM pg_catalog.pg_type t
          LEFT JOIN pg_catalog.pg_namespace n ON n.oid = t.typnamespace
          -- LEFT JOIN pg_catalog.pg_enum e ON t.oid = e.enumtypid
          WHERE t.typtype = 'e'
     """

     SQL_ENUMS += 'ORDER BY "schema", "name"'

### mysql

    pip install mysqlclient

    prefix - mysql

you can add `charset=utf8` to specify encoding:

    mysql://username:password@ipaddress/databasename?charset=utf8

### sqlserver

    yum install freetds-devel # for sqlfont.h maybe need export C_INCLUDE_PATH=/usr/include (or other path for head files)

    yum install unixODBC-devel # for sql.h

    pip install pymssql

    prefix - mssql+pymssq
