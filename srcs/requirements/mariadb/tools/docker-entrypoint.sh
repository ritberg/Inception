#!/bin/sh
set -e
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT SIGHUP

some_app &
wait