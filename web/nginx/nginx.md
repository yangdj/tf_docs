# nginx

## location

`root` and `alias` can be both used to specifying the path to find the files.

for `root`:

    location ^~ /t/ {
        root /www/root/html
    }

`/t/a.html` will be mapped to `/www/root/html/t/a.html`

for `alias`

    location ^~ /t/ {
        alias /www/root/html/ # note the `/` at the end of the path
    }

`/t/a.html` will be mapped to `/www/root/html/a.html`
