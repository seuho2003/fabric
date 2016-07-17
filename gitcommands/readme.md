###Delete Remote Branch:
`git push upstream :<branchName>` or `git push upstream --delete <branchName>`

###Delete Local Branch:
`git branch -D <branchName>`

###View just remote-tracking branches
```
git branch --remotes
git branch -r
```

###View both strictly local as well as remote-tracking branches
```
git branch --all
git branch -a
```
###Delete all the remote branch which are not exited in local

```git push --prune origin``` <<Double check remote name>>

###Rename git branch

```
git branch -m <oldName> <newName>```
git push upstream :oldname < Deletes old branch from remote>
git push --set-upstream origin newName <new local to track a new remote branch>
```

###Sync Remote Rep with local and push changes to remote repo
```
git remote add upstream https://github.com/rameshthoomu/fabric.git
git fetch upstream
git merge upstream/master
git push upstream master
```
###Changing remote url's
```
git remote -v
$ git remote -v
origin  https://github.com/hyperledger/fabric.git (fetch)
origin  https://github.com/hyperledger/fabric.git (push)
upstream        https://github.com/rameshthoomu/fabric.git (fetch)
upstream        https://github.com/rameshthoomu/fabric.git (push)
git remote set-url upstream https://github.com/rameshthoomu79/fabric.git <new url>
upstream        https://github.com/rameshthoomu79/fabric.git (fetch)
upstream        https://github.com/rameshthoomu79/fabric.git (push)
```
