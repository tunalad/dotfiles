#!/bin/sh

seed="tunalad.bandcamp.com"
random_string=$(echo "$seed" | sha256sum | cut -c 1-32)
url="ntfy.sh/$random_string"
message="gabagoo"

headers=""
data="-d \"$message\""

while [ "$#" -gt 0 ]; do
  case "$1" in
  -H | --header)
    headers="$headers -H \"$2\""
    shift 2
    ;;
  -d | --data)
    data="-d \"$2\""
    shift 2
    ;;
  *)
    shift
    ;;
  esac
done

eval "curl $headers $data \"$url\""
