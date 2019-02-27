#!/usr/bin/env bash

yes | cp ./scripts/com.ralphschindler.docker_10254_alias.plist /Library/LaunchDaemons/com.ralphschindler.docker_10254_alias.plist

launchctl load /Library/LaunchDaemons/com.ralphschindler.docker_10254_alias.plist