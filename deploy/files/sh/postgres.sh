#! /usr/bin/env bash

if [ -d /usr/local/pgsql ]; then
    export LD_LIBRARY_PATH=/usr/local/pgsql/lib:${LD_LIBRARY_PATH}
    export PATH=/usr/local/pgsql/bin:$PATH
fi
