# homebrew

## brew

mainly for command line applicaions. you can also use information from `brew info` to start application backend, and `brew options` to specify options to compile application.

* `brew update` - updates `brew` 
* `brew list formula` - lists formulas
* `brew (info|home|options) formula` - shows details about formula
* `brew search formula` - searches formulas
* `brew install formula` - install formula
* `brew uninstall formula`  - uninstall formula
* `brew upgrade` - updates formula. without specifing the formula, will update all formulas
* `brew services start|stop|restart|list` - manages services

## brew cask

mainly for graphical applications, similar to `brew`.

* `brew cask update`
* `brew cask search`
* `brew cask (info|home|list)`
* `brew cask install`
* `brew cask uninstall`
* `brew doctor` - checks for configuration issues
* `brew cask zap` - tries to remove all files associated with a cask, may include resources shared with other applicaions
