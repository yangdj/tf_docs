# create airflow login user

import airflow
from airflow import models, settings
from airflow.contrib.auth.backends.password_auth import PasswordUser
user = PasswordUser(models.User())
user.username = 'airflow'
user.email = 'new@example.com'
user.password = 'airflow'
# user.superuser = True
session = settings.Session()
session.add(user)
session.commit()
session.close()
