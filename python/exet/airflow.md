# airflow

## install and config

    pip install apache-airflow
    pip install Fernet cryptography
    pip install "apache-airflow[password]" # Password Authentication for users
    pip install "apache-airflow[mssql]"
    pip install "apache-airflow[hive]"

    airflow initdb
    airflow webserver -p 8080 # you can set load_example = False

    sudo firewall-cmd --permanent --add-port=8080/tcp
    sudo systemctl reload firwalld

when using `CeleryExecutor`, you have to install `rabbitmqserver` first, then

    pip install "apache-airflow[celery]"

    may be you have to install "apache-airflow[rabbitmq]" from source
    change "except Exception, e" to "except Exception as e"
    then tar > python setup.py build > python setup.py install

when using `postgresql` database, you have to install:

    pip install psycopg2-binary

then in the `airflow.cfg` file, change the configuration:

    load_examples = False
    sql_alchemy_conn = postgresql+psycopg2://airflow:airflow@localhost:5432/base
    sql_alchemy_conn = mysql://airflow:airflow@localhost/airflow?charset=utf8
    executor = CeleryExecutor
    broker_url = amqp://myairflow:airflowpass@localhost:5672/myvhost
    celery_result_backend = db+postgresql://airflow:airflow@localhost:5432/airflow
    celery_result_backend = db+mysql://airflow:airflow@localhost/airflow?charset=utf8

authenticate:

    authenticate = True
    auth_backend = airflow.contrib.auth.backends.password_auth

then create an user:

    import airflow
    from airflow import models, settings
    from airflow.contrib.auth.backends.password_auth import PasswordUser
    user = PasswordUser(models.User())
    user.username = 'new_user_name'
    user.email = 'new_user_email@example.com'
    user._set_password = 'set_the_password'
    session = settings.Session()
    session.add(user)
    session.commit()
    session.close()
    exit()

## command

deploy:

* `cp airflow.conf /etc/tmpfiles.d/`
* `mkdir /run/airflow; chown airflow:airflow /run/airflow`

dag:

* `python your_dag_file` - test your dag
* `airflow list_dags`
* `airflow list_tasks your_dag_name [--tree]`
* `airflow test your_dag dag_task execute_date`
* `airflow backfill your_dag -s startdate -e enddate` - execute jobs that are not done in the past

start server:

* `journalctl -u airflow-webserver.service -e`
* `airflow webserver -p 8000`
* `airflow scheduler`
* `airflow worker`
* `airflow flower` - default port `5555`
