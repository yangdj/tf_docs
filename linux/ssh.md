# ssh

* `ssh-keygen -t rsa` - creates key
* `ssh -T git@github.com` - for test
* `ssh user@host`
* `ssh host` - if local user is identical to remote user
* `ssh -p 2222 user@host` - specify port, for example 2222
* `ssh-copy-id user@host` - add public key to remote user
* `ssh user@host 'mkdir -p .ssh && cat >> .ssh/authorized_keys' < ~/.ssh/id_rsa.pub` - similar to ssh-copy-id
