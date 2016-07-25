#!/bin/sh

# This script is called when changes are stored in:
# /Library/Preferences/SystemConfiguration/preferences.plist
#
# It can be used to execute actions when a location changes.
# Nota bene: this script will run every time that file changes,
# not only location changes.

# Get the name of the Location, as found under "(apple) - Location".
LOCATION=$(/usr/libexec/PlistBuddy -c "Print :Sets:$(/usr/libexec/PlistBuddy -c "Print :CurrentSet" /Library/Preferences/SystemConfiguration/preferences.plist | sed 's/\/Sets\///'):UserDefinedName" /Library/Preferences/SystemConfiguration/preferences.plist)

logger "Found location: ${LOCATION}"

# There are 3 cases here:
# "Work" that places some files.
# "Automatic" that moves the same files away.
# "*" (any other) that just notifies no actions are configured.
#
# Change the actions with whatever you like.

case ${LOCATION} in
  Work)
    logger "Found commands for ${LOCATION}"
    if [ -d /etc/resolver.not ] ; then
      logger "Activating /etc/resolver"
      sudo mv /etc/resolver.not /etc/resolver
    fi
  ;;
  Automatic)
    logger "Found commands for ${LOCATION}"
    if [ -d /etc/resolver ] ; then
      logger "De-activating /etc/resolver"
      sudo mv /etc/resolver /etc/resolver.not
    fi
  ;;
  *)
    logger "No commands specified for ${LOCATION}" 
  ;;
esac
