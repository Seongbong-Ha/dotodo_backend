from datetime import datetime
from airflow import DAG
from airflow.operators.bash import BashOperator

dag = DAG(
    'working_test',
    start_date=datetime(2025, 9, 26),
    schedule=None,
    catchup=False,
    tags=['test']
)

test_task = BashOperator(
    task_id='hello_world',
    bash_command='echo "Airflow 3.0 Working!"',
    dag=dag
)
