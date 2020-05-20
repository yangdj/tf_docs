# logging

## logging function

* logging.debug()
* logging.info()
* logging.warning()
* logging.error()
* logging.critical()
* logging.exception()

## logging config

`logging.basicConfig()` should run before logging functions.

* filename - file path
* stream
    * sys.stderr - default
    * sys.stdout
* filemode
    * "a" - default
    * "w"
* format
    * %(name)s - logger name
    * %(levelname)s
    * %(message)s
    * %(asctime)s - logger time
    * %(pathname)s
    * %(filename)s
    * %(module)s
    * %(lineno)d
    * %(funcName)s
    * %(thread)d
    * %(threadName)s
    * %(process)d
    * %(processName)s
* datefmt
    * %Y-%m-%d %H:%M:%S - default,  e.g., 2017-01-23 21:05:23
* level
    * logging.NOTSET=0
    * logging.DEBUG=10
    * logging.INFO=20
    * logging.WARNING or WARN=30
    * logging.ERROR=40
    * logging.CRITICAL=50
* style - specify the type of format string
    * "%" - default
    * "{"
    * "$"

`logging.config.fileConfig("log.conf")` uses configuration file to configure logging

## usage

for logger:

* logger = logging.getLogger(__name__) # __name__ is a good choice
* logger.setLevel()
* logger.addHandler()
* logger.removeHandler()
* logger.addFilter()
* logger.removeFilter()

for handler:

* handler type
    * logging.FileHandler
    * logging.StreamHandler
    * logging.NullHandler
* functions
    * hd.setLevel()
    * hd.setFormatter()
    * hd.addFilter()
    * hd.removeFilter()

for formatter:

* logging.Formatter()


    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)

    fd = logging.FileHandler("file.log")
    fd.setLevel(logging.WARNING)

    console = logging.SteamHandler(sys.stderr)
    console.setLevel(logging.INFO)

    fmt = "%(name)s %(asctime)-15s %(levelname)s %(filename)s %(lineno)d %(process)d %(message)s"
    datefmt = "%Y-%m-%d %H:%M:%S"
    formatter = logging.Formatter(fmt, datefmt)

    fd.setFormatter(formatter)
    console.setFormatter(formatter)

    logger.addHandler(fd)
    logger.addHandler(console)
