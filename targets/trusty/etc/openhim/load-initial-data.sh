#!/bin/bash
set -e

server="localhost:8080"
username="root@openhim.org"
pass="openhim-password"

declare -a clients
declare -a channels
declare -a users

# set internal field separator to nothing else it separates array elements by a
# space
OIFS=$IFS
IFS=

while read -r client
do
  clients+=($client)
done < <(jq -r '.Clients[] | tostring' /etc/openhim/data.json)

while read -r channel
do
  channels+=($channel)
done < <(jq -r '.Channels[] | tostring' /etc/openhim/data.json)

while read -r user
do
  users+=($user)
done < <(jq -r '.Users[] | tostring' /etc/openhim/data.json)

# reset IFS to original value
IFS=$OIFS

auth=`curl -k -s https://$server/authenticate/$username`;
salt=`echo $auth | jq -r '.salt'`;
ts=`echo $auth | jq -r '.ts'`;

passhash=`echo -n "$salt$pass" | shasum -a 512 | awk '{print $1}'`;
token=`echo -n "$passhash$salt$ts" | shasum -a 512 | awk '{print $1}'`;

for client in "${clients[@]}"
do
  echo "=====Attempting to insert a CLIENT======"
  curl -k -H "Content-Type: application/json" -H "auth-username: $username" -H "auth-ts: $ts" -H "auth-salt: $salt" -H "auth-token: $token" -d "$client" -X POST -v https://"$server"/clients
  echo
  echo "=====DONE======"
done

for channel in "${channels[@]}"
do
  echo "=====Attempting to insert a CHANNEL======"
  curl -k -H "Content-Type: application/json" -H "auth-username: $username" -H "auth-ts: $ts" -H "auth-salt: $salt" -H "auth-token: $token" -d "$channel" -X POST -v https://"$server"/channels
  echo
  echo "=====DONE======"
done

for user in "${users[@]}"
do
  echo "=====Attempting to insert a USER======"
  curl -k -H "Content-Type: application/json" -H "auth-username: $username" -H "auth-ts: $ts" -H "auth-salt: $salt" -H "auth-token: $token" -d "$user" -X POST -v https://"$server"/users
  echo
  echo "=====DONE======"
done
