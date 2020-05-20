# ipython

1. run SQL inside ipython

        %load_ext pgcli.magic
        %pgcli postgres://someone@localhost:5432/world
        the next time, you can directly use "%pgcli", then execute sql
        result = _
