# crontab

* `-l` - list tasks
* `-e` - edit tasks
* `-r` -remove all tasks

## format

    minute  hour    dayofmonth  month   dayofweek           command
    0-59    0-23    1-31        1-12    0-7 0,7 for sunday  your-command

## special character

* `*` - for any time

        * 12 * * *

* `,` - for interval

        * 12,13,14 * * *

* `-` - for range

        * 12-14 * * *

* `/` - for every

        * */2 * * *
