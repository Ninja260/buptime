#!/bin/bash

# log suspend and resume unixtimestamps

logfile="/var/log/on_suspend_and_resume.log"

timestamp=$(date +%s)

case "$1" in
pre)
  echo "S $timestamp" >>"$logfile"
  ;;
post)
  echo "R $timestamp" >>"$logfile"
  ;;
*)
  # nothing
  ;;
esac
