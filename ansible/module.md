# ansible modules

* `ansible-doc -l` - list modules
* `ansible-doc module-name` - module info

## yum

manage `yum` packager.

```yaml
yum:
  name: package | package-1.0 | a package lists or "{{ packages }}"
  state: present or installed | absent or removed | latest
```

## file

Sets attributes of files, symlinks, and directories, or removes files/symlinks/directories.

```yaml
file:
  src: # path of the file to link to, only for `state=link|hard`
  path|dest: # file being managed
  state: file (default) | directory | link (symbolic link) | hard (hard links) | touch | absent
  mode: 0755 | "u+rw,g-wx,o-rwx"
  owner:
  group:
```
## synchronize

a wrapper around `rsync`.

```yaml
synchronize:
  src:
  dest:
  mode: push (default) | pull
  delete: no (default) | yes # delte files in `dest` that don't exist in the `src` path
```

## shell

```yaml
shell: |
  echo hello, world! 
  echo come back!
args:
  chdir: somedir/
  executable: /bin/bash
  creates: create.txt
  removes: remove.txt
```

## blockinfile

when using looping, make sure every loop has a distinct `marker`, otherwise, the next block will overwrite the previous block.

```yaml
blockinfile:
  path: ~/.bashrc
  create: yes | no # create a new file if it doesnot exist
  marker: "# {mark} ... " 
  block:
```

## include_vars

```yaml
include_vars:
  file:
  dir:
  name:
  extensions: ["yaml", "yml", "json"] (default) # when using "dir"
```
