# permissions

## owners and groups

all user's information is stored in the file `/etc/passwd`, `/etc/shadow`, and `/etc/group`.

* `/etc/passwd` includes  name, password, userid, groupid, user's comment, home directory, and default shell information of users
* `/etc/shadow` includes user's passwd information
* `/et/group` includes user's group information

after creating the new user, files in `/etc/skel` directory will be copied to the user's home directory. the default configuration is stored in `/etc/default/useradd`.

### user operations

`useradd` for adding a new user. you can add a new user called `test` in this way:

    useradd -m -d /home/test -s /bin/bash -c 'for test' -g test -G root,admin test

* `-m` - create home directory if it does not exist, otherwise, the new user will not have it's home directory. or you have to create the directory after creating the new user manually
* `-d` - specifies home directory path, the default is `/home/test`. `test` is the new user's name
* `-s` - specifies a default shell
* `-c` - comment for the user
* `-g` - specify a default group the new user, if not used, the default group name will be the same as the new user's name
* `-G` - adding more groups that the new user will belong to
* `test` - the new user's name

after creating a new user, you have to create a password for the user, otherwise the new user is not allowed to use:

    passwd test

`usermod` for modifing user's information. you can use it similar to `useradd`:

    usermod -m -d /home/test1 -c 'update info' -s /bin/bash test

you can also use `usermod` to add more groups to a user, `-a`, `-G` will be used together:

    usermod -a -G root,abc test

the `test` user will also belong to the `root` and `abc` group.

    usermod -g abc test

will modify `test`'s default group to `abc`. `-g` is used to specify a default group.

`userdel` for deleting a user:

    userdel -r test

using `-r` will also delete the new's home directory, otherwise, the home directory will be keeped.

### group operations

you can use `groupadd`, `groupdel`, `groupmod` to add, delete or modify a group:

`groupadd test` - adds a `test` group
`groupadd -g 101 test` - adds `test` group, and specifies its group id to `101`
`groupdel test` -  deletes the `test` group
`groupmod -n test1 test` - modify the group name `test` to `test1`
`groupmod -g 1001 test` - modify the group `test` to use group id `1001`

use `newgrp` to switch current user's group to another group it has, then you can use the switched group's identity:

    newgrp test1

### user information

`id` shows user's data:

* `-u` - uid
* `-g` - gid
* `-G` - groups id

`$USER` shows user's name.

## reading, writing executing and other rights

for files, `r` means, you can open and read the file. `w` means, you can modify the file's content. but the file is not allowed to be renamed or deleted. the ability to delete or rename file is determined by directory attributes. `x` means, you can execute the file, but you shold have the `r` reading right to execute the file.

for directory, `r` means you can list the directory contents if you have `x` executing right, otherwise, you can just read the files' names within the directory. other information will be displayed as `?`. `w` means, you can create, delete, and rename files within the directory if you have `x` right. `x` means, you can enter the directory, e.g., `cd` the directory.

there are also other permission settings. the first is the *setuid* bit (octal 4000). when applied to an executable file, it sets the *effective user* id from that of the *real user* (the user actually running the program) to the program's owner. 

the second is `setgid` bit (octal 2000) which, like the the `setuid` bit, changes the *effective group* id from the *real group* id of the real user to that of the file owner. the second is `setgid` bit (octal 2000) which, like the the `setuid` bit, changes the *effective group* id from the *real group* id of the real user to that of the file owner. if the `setgid` bit is set on a directory, newly created files in the directory will be given the group ownership of the directory rather the group ownership of the file's creator. this is useful in a shared directory when members of a common group need access to all the files in the directory, regardless of the file owner's primary group.

the third is called the `sticky` bit (octal 1000). on files, linux ignores the `sticky` bit, but if applied to a directory, it prevents users from deleting or renaming files unless the user is either the owner of the directory, the owner of the file, or the superuser. this is often used to control access to a shared directory, such as /tmp.

### attributes operations

`su` runs a shell with *substitute user and group ids*:

    su test
    su -l test
    su
    su -

if `-l` option is included, the resulting shell session is a login shell for the specified user. this means that the user's *environment* is loaded and the working directory is changed to the user's home directory. `-l` can be abbreviated `-`, which is how it is most often used. if the *user* is not specified, the *superuser* is assumed. using `exit` command returns to the previous shell.

    su -c 'command'

you can execute a single command this way rather than starting a new interactive command.

`sudo` executes a command as another user, usually as a *superuser*, but uses only its own password. `sudo` dose not start a new shell, nor does it load another user's environment. this means that commands do not need to be quoted any differently than they would be without using `sudo`. `sudo -l` lists privileges granted to sudo.

you can use `sudo EDITOR=vim visudo` to edit the *sudoer* file using `vim` editor, then add a line `Defaults editor=/usr/bin/vim (your vim's path)`. after this, when executing `sudo visudo`, you will edit the file using the vim editor, the default editor may be `nano` which is not convenient to use. keeping useing `sudo visudo` to configure sudoers, not edit the `/etc/sudoers` file.

`umask` controls the default permissions given to a file when it is created. it uses octal notation to express a mask of bits to be removed from a file's mode attributes:

    umask 0022

`chmod` can be used to modify the file's access attributes. you can use octal number representation, or symbolic representation ways:

    chmod 755 test.txt

    chmod u=rwx,g=rx,o=rx test.txt

    chmod u+x,a+r,g-w test.txt

    chmod u+s program

    chmod g+s dir

    chmod +t dir

    chmod -t dir

`chown` changes file owner and group. the syntax is `chown [owner][:[group]] file ...`.

* `chown bob test.txt` - changes the file owner to bob, group owner unchanged.
* `chown bob:bobs test.txt` changes the file owner to bob, group owner to bobs.
* `chown :bobs test.txt` changes group owner to bobs, file owner unchanged
* `chown bob: test.txt` changes file owner to bob, group owner to bob's login group
