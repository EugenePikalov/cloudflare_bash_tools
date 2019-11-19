#!/bin/sh

# Block IP by list from file ./badIPList

Key=""
Email=""
badIPList="./badIPList"
mode="challenge" # challenge, block, js_challenge
note="ddos`date +"%Y%m%d"`"


# cat /var/log/nginx/access.log | grep "01/Nov/2019:20:15" | grep "\"-\" \"-\"" | awk '{ print $1}' | sort| uniq > badIPList

while read host; do
    hostparts=($host)

    curl -X POST "https://api.cloudflare.com/client/v4/user/firewall/access_rules/rules" \
    -H "X-Auth-Key:$Key" \
    -H "X-Auth-Email:$Email" \
    -H "Content-Type:application/json" \
    --data "{\"mode\":\"$mode\",\"configuration\":{\"target\":\"ip\",\"value\":\"${hostparts[0]}\"},\"notes\":\"$note\"}"
done < $badIPList

