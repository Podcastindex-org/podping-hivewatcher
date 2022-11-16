# podping-hivewatcher
A watcher script for the hive backed podping network.

## Blockchain Watcher (hive-watcher.py)

The stream of *podpings* can be watched with the ```hive-watcher.py``` code. 

```
usage: hive-watcher [options]

PodPing - Watch the Hive Blockchain for notifications of new Podcast Episodes This code will run until terminated 
reporting every notification of a new Podcast Episode sent to the Hive blockchain by any PodPing servers.

With default arguments it will print to the StdOut a log of each new URL that has updated interspersed with 
summary lines every 5 minutes that list the number of PodPings and the number of other 'custom_json' operations 
seen on the blockchain. This interval can be set with the --reports command line.

optional arguments:
  -h, --help          show this help message and exit
  -H, --history-only  Report history only and exit
  -d, --diagnostic    Show diagnostic posts written to the blockchain
  -r , --reports      Time in MINUTES between periodic status reports, use 0 for no periodic reports
  -s , --socket       <IP-Address>:<port> Socket to send each new url to
  -t, --test          Use a test net API
  -q, --quiet         Minimal output
  -v, --verbose       Lots of output

  -b , --block        Hive Block number to start replay at or use:
  -o , --old          Time in HOURS to look back up the chain for old pings (default is 0)
  -y , --startdate    <%Y-%m-%d %H:%M:%S> Date/Time to start the history
```


## Podping Watcher (hive-watcher.py)

The watcher script is how you see which podcast feed urls have signaled an update.

This is the easiest way to watch the blockchain for feed updates.  Simply do the following:

1. Clone this repo.
2. Switch to the `hive-watcher` sub-directory.
3. Make sure python3, pip3 and [poetry](https://python-poetry.org/docs/#installation) are installed.
4. Run `poetry install`.
5. Launch the watcher script like this: `poetry run python3 -u ./hive-watcher.py --json`

Each time a feed update notification is detected on the blockchain, the full json payload of the feed update is printed to STDOUT on a new line.  Each
FQDN that is output represents a new episode that has been published, or some other significant update to that podcast feed.

You can watch this output as a way to signal your system to re-parse a podcast feed.  Or you can use it as a starting template to
develop a more customized script for your environment.  It's dead simple!

There is an example PHP script [here](examples/php/podping_watcher.php) that you can pipe this output to as a way to update your system every
time a new podping url comes through.  You would do that like this:

```bash
poetry run python3 -u ./hive-watcher.py --json --unix_epoch=$((`date +'%s'` - 30)) | php ../examples/podping_watcher.php
```

The `--unix_epoch` argument above tells the hive-watcher script to look back 30 seconds in the past and start watching from that point in time.  You
can adjust that argument value to look back to any arbitrary point in time and start catching up from there.