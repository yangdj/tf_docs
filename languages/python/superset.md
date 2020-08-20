# superset installation for `superset`

## prepare

* `pip3 install superset` - install superset
* `fabmanager create-admin --app superset` - create an admin user
* `superset db upgrade` - initialize the database
* `superset load_examples` - load some data to play with
* `superset init` - create default roles and permissions
* `superset runserver` - start the webserver, to start a development webserver, use the `-d` option
* `kill pid(from superset runserver)` - shutdown the webserver

## customer configuration

### meta data storing

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

### postgresql

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

## translations messages.po

you can first edit `messages.po` file, and translate to your language, then execute `msgfmt messages.po -o messages.mo`.

### superset operations

* title - `config.py:APP_NAME`
* logo - `config.py:APP_ICON`
* icon - `/static/assets/images/favicon.png`
* `version superset documentation` - comment `templates/appbuilder/navbar.html`

### user's profile page

    static/assets/dist/profile.8aff82e12ea695fd48d9.entry.js

    line 51:
    Favorites - 收藏
    Created Content - 已创建
    Recent activity - 最近活动
    Security & Access - 安全 & 访问
    Dashboards - 驾驶舱
    Slices - 切片
    Roles - 角色
    Datasources - 数据源

    static/assets/dist/sqllab.ecdbeb9e395347331fa4.entry.js
    Run Query - 执行
    Stop - 停止
    Save Query - 保存 createElement(c.Tab { title:"Results" } - title: "查询结果"
    Run Selected Query - 执行已选择的查询
    title:"Query History" - "历史查询"
    "Run a query to display results here" - 此处浏览查询结果
    "No query history yet..." - 还没有查询过...
    "The query returned no data" - 没有符合条件的数据
    close tab - 关闭标签页
    rename tab - 重命名标签页
    share query - 分享查询
    hide tool bar - 隐藏工具栏
    expand tool bar - 展开工具栏
    htmlFor:"embed-height"},"Label" - 名称
    htmlFor:"embed-height"},"Description" - 描述
    className:"text-muted"},"Database:" - 数据库
    "Select a schema (" - "选择一个 schema ("
    "Type to search ..." - "输入查询项 ..."
    Save - 保存
    Cancel - 取消
    "Write a description for your query" - 描述一下你的查询
    title:"Preview for " - "预览 "
    Add a table - 表格查询
    Fetch data preview - 获取预览数据

    static/assets/dist/explore.3e37f28a03b20c5687e8.entry.js
    createElement("i" { className:"fa fa-bolt"}),"Query") } - 查询
    createElement("i" { className:"fa fa-plus-circle"})," Save")} - 保存
    Datasource & Chart Type - 数据源 & 图表类型
    type:"DatasourceControl",label:"Datasource" - 数据源
    type:"VizTypeControl",label:"Visualization Type" - 图表类型