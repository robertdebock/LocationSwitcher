# LocationSwitcher
A set of scripts to execute scripts when changing network location on MacOS (or Mac OS X)

This repository contains just 2 files of importance:
- locationswitcher.sh - A script to do actions.
- local.locationswitcher.plist - A launchagent that calls locationswitcher.sh

Place the locationswitcher.sh anywhere, i.e. /usr/local/bin.
Place the local.locationswitcher.plist in ~/Library/LaunchAgents.

You need to edit local.locationswitcher.plist to refer to the locationswitcher.sh script.
After that's placed, activate the configuration:

    launchctl load /Users/robertdb/Library/LaunchAgents/local.robertdb.locationswitcher.plist

When you open Console and filter for "Process: logger", you'll see information.

Good to know; this script is executed each time any system change occurs.
