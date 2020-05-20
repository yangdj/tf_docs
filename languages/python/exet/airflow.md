# airflow

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
