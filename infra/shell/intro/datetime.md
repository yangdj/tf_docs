# datetime

`date` - print and set date and time

## time format

* `%Y` - year
* `%m` - month (01..12)
* `%d` - day (01..31)
* `%H` - hour (00..23)
* `%M` - minute (00..59)
* `%S` - second (00..60)
* `%N` - nanoseconds
* `%s` - seconds from 1970-01-01 00:00:00 UTC
* `%F` - equals to `%Y-%m-%d`
* `%T` - equals to `%H:%M:S`
* `%j` - the nth day of the year
* `%%` - output `%`

## datetime and string conversion

from string to datetime:

    date -d '2011-01-11 11:11:11'

from datetime to string

    date +"%Y-%m-%d %H:%M:%S"

## time interval

you can get different time between two times as follows:

1. get the timestamp from the two times
2. get the difference from the two timestamps
3. convert the difference as you need

## some examples

* `date  +"%Y-%m-%d %H:%M:%S"` - get current datetime, using specified format
* `date -d "-1 day" +%Y%m%d` - yesterday
* `date +%s` - get current timestamp
* `date -d @timestamp` - get datetime from specified timestamp value
* `date --utc -d @0` or `date -u -d @0` - get utc start time
