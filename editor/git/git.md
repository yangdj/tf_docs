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
