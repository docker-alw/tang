#!/bin/ash
# shellcheck shell=dash

set -x -e -o pipefail

test -L "/bin/tangd"
# shellcheck disable=SC2010
ls -l "/bin/tangd" | grep "/libexec/tangd"
test -d "/var/db/tang"

/bin/tangd --version
