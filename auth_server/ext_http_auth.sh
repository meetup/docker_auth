#!/bin/sh

main() {
  read user pass
  local url="$1"
  local status_code=$(curl -s -o /dev/null \
    -w "%{http_code}" \
    -X POST \
    --data-urlencode "user=$user" \
    -H "Content-Type:application/json" $url -d "$pass")
   if [ "$status_code" -eq "200" ]; then
     exit 0
   elif [ "$status_code" -eq "401" ]; then
     exit 1
   elif [ "$status_code" -eq "404" ]; then
     exit 2
   else
     exit 3
   fi
}

main "$@"
