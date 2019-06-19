#!/bin/sh

illnessfile=/tmp/illness

if test -f $illnessfile; then
  echo -n 'I am ill'
  exit 1
fi

echo -n 'I am well'
exit 0
