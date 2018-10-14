# mysql configuration

## installation

### for mac

* `brew install mysql`
* `brew services start mysql` to have launched `mysql` now an restart at login.
* `mysql.server` just launches mysql, without running in the background service.

### for centos

use `mariadb`

* `yum install mariadb-server`
* `systemctl start mariadb`
* `systemctl enable mariadb`
* `sudo mysql_secure_installation` for secure processing, and provides a detailed explanation for every step, setting you root password, removing anonymous users, disallowing remote root login, removing the test database, and reload the priviledge tables. then you can skip the following command, that is setting password for `root`.
* `mysqladmin -u root password 'root'`
* `GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' identified by 'root' WITH GRANT OPTION;`
* `flush privileges;`
* `/sbin/iptables -I INPUT -p tcp --dport 3306 -j ACCEPT`
