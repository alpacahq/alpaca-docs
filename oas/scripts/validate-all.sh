#!/usr/bin/env bash

#A simple script to loop over all our spec files and `npm run validate` on them

set -e

SCRIPT_DIR=$(dirname "$0")

#import shared list of spec files
source "$SCRIPT_DIR"/spec_files.sh

#make sure we're in the same dir as our package json so our paths work as expected
pushd "$SCRIPT_DIR"/../ >> /dev/null

#re-enable e flag so we don't stop running after first failed lint
set +e

FAILED_A_VALIDATION_PASS=0

for dir in $SPEC_FILES
do
  if ! npm run validate "$dir/openapi.yaml"; then
    FAILED_A_VALIDATION_PASS=1
  fi
done

set -e

#go back
popd >> /dev/null

exit $FAILED_A_VALIDATION_PASS
