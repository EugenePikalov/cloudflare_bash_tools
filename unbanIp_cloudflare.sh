#!/bin/bash

# Remove Cloudflare rules by name

# Requirements:
# yum install jq


Email=""
Key=""
filterByNotesName="ddos"

ruleList=`curl -s -X GET "https://api.cloudflare.com/client/v4/user/firewall/access_rules/rules"   \
      -H "X-Auth-Key:$Key"    \
      -H "X-Auth-Email:$Email"  \
      -H "Content-Type:application/json" | jq  ".result[] | select(.notes == \"$filterByNotesName\") | .id"`;

       for ruleid in $ruleList;
        do
         ruleid=`echo "$ruleid" | tr -d '"'`
         curl -X DELETE "https://api.cloudflare.com/client/v4/user/firewall/access_rules/rules/$ruleid" \
                -H "X-Auth-Key:$Key" \
                -H "X-Auth-Email:$Email" \
                -H "Content-Type: application/json"
         done
