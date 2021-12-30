#!/usr/bin/env bash

# staging, production, etc.
TF_ENV=$1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Always run from the location of this script
cd $DIR

if [ $# -gt 0 ]; then # this means if number of arguments passed are greater than zero
  if [ "$2" == "init" ]; then # $2 = init, plan, apply, etc.
    terraform -chdir=./$TF_ENV init --backend-config ../backend-$TF_ENV.tf
  else
    terraform -chdir=./$TF_ENV $2
  fi
fi

# Head back to the original location to avoid surprises
cd -
