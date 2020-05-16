# git

## basic

every repository should inlcuede following files:

* `README`
* `LICENCE`
* `.gitignore`

push an existing repository:

    git remote add origin git@github.com:user/repo.git
    git push -u origin master

## repository creation                                                                   

* `git init` - creates a repo based on an existing repo. 
* `git init new-repo-name` - creates a new repo called new-repo-name.

or `git clone host-repo local-repo-name`, you can use many protocals to get *host-repo*:

* `local` - `git clone /opt/git/project.git`
* `git` - `git clone git://example.com/path/to/repo.git/`
* `http[s]` - `git clone http[s]://example.com/path/to/repo.git/`
* `ssh` - `git clone ssh://example.com/path/to/repo.git/`
* `ssh` - `git clone user@example.com:path/to/repo.git`
* `ftp[s]` - `git clone ftp[s]://example.com/path/to/repo.git/`
* `rsync`- `git clone rsync://example.com/path/to/repo.git/`
* `file` - `git clone file:///opt/git/project.git`

normally, the `git` protocal is the fastest for downloading, and `ssh` is used for authentication.

## branch

 `git branch -r` - lists remote branches
 `git branch -a` - lists all branches, remote and local
 `git branch new-branch` - creates a new branch `new-branch`
 `git chechout master` - switches to branch `master`
 `git chechout -b new-branch` - creates a new branch named `new-branch` and switches to the new branch
 `git branch -d deleted-branch` - deletes branch `deleted-branch`

 ## file comparison

 * `git diff` - diff between working tree and staged
 * `git diff --cached` `git diff --staged` - diff between staged and `HEAD` (last commit)
 * `git diff HEAD` diff between working tree and `HEAD` (last commit)
 * `git diff <source_branch> <target_branch>` - diff between branches

 ## remote operation
 
 ### host connection
 
 * `git remote` - lists remote hosts
 * `git remote -v` - lists host information
 * `git remote show host` - shows detail information about host
 * `git remote add  origin git@github.com:your/reop/path/repo.git` - adds a host. if you want to synchronize with github just using *public key*, you have to use `ssh` protocal, not `https` protocal
 * `git rename pb paul` - renames host from pb to paul
 * `git remote rm origin` - removes remote repo host

 ### synchronization

 `git fetch` fetches remote updates to local repo:

 * `git fetch origin` - fetches all updates from host `origin`
 * `git fetch origin master` -  fetches specified branch `master` updates from host `origin`
 * `git merge origin/master` - merges remote branch `origin/master` with current local branch
 * `git checkout -b new-branch origin/master` - creates a new-branch based on remote branch `origin/master`

 `git pull` fetches remote updates to local repo, and then merges with current local branch. the full format is `git pull remote-name remote-branch:local-branch`.

 * `git pull origin next:master` - fetches branch `next` from host `origin`, and merges with local branch `master`
 * `git pull origin next` - fetches branch `next` from host `origin`, and merges with current local branch, similar to `git fetch origin; git merge origin/next`
 * `git pull origin` - merges current local branch with the tracking branch from host `origin`
 * `git pull` - if current local branch has only one tracking branch, you can omit host `origin`, meanings merging current local branch with its tracking branch
 * `git pull -p` - deletes local branch if that branch is removed from remote host

you can also use `git pull --rebase remote-name remote-branch:local-branch` for merge in `rebase` way.

`git push` pushes local updates to remote host. the format is `git push remote-name local-branch:remote-branch`.

* `git push origin local:remote` - pushes local branch `local` to remote branch `remote` in host `origin`
* `git push origin local` - pushes local branch `local` to the remote tracking branch in host `origin`, if the tracking branch is not existing, then a new remote tracking branch will be created
* `git push origin` - pushes current local branch to the remote tracking branch in host `origin`
* `git push` - if current branch has only one tracking branch, you can omit host name `origin`
* `git push origin :remote` - if omitting local branch, will delete the remote branch `remote`, similar to push an empty branch to remote branch. you can also use `git push origin --delete master` to delete remote branch `master` in host `origin`
* `git push -u origin master` - if current local branch has more than one tracking branches, you can specify a default host. `-u` specifies a default host `origin`. this command means, pushes local branch `master` to remote host `origin`, and `origin` will be default host for local branch `master`. you can initialize remote with local branch in this way
* `git push -all origin` - pushes all local branches to remote host `origin`, no matter whether the remote host has the corresponding trackings to local branches. if remote branch versions are newer than local versions, you have to `git pull` first, and then `git push`. if you insist doing this, you can use `git push --force origin`. this will cause local branch versions overriding the remote branches, even if the remote branches are newer then local branches. this is not advised
* `git push origin --tags` - uses `--tags` to push tags to remote
