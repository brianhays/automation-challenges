#!/bin/sh

# Scrape It!
# 
# author: Brian Hays
#
# usage: this script will scrape Apache's "common" format logs for the following items:
#        - How many times the URL (set as: GET_URL) was fetched
#           - ...of the above requests, how many return codes other than 200
#        - The total number of times Apache returned ANY code other than 200
#        - The number of times that an IP address sent a PUT request to a path (set as: PATH_URL)
#           - ...a breakdown of how many times such requests were made by IP address
#
#
# notes: when run with no arguments, this script will scrape logfile named "puppet_access_ssl.log"
#        (optional: a file name can be passed as an argument when running the script (such as: "sh scrape_it.sh myfile.log"))
#
set -u        

GET_URL="/production/file_metadata/modules/ssh/sshd_config"
PUT_URL="/dev/report/"

if [ $# -ge 1 ]
then
    LOG_FILE="$1"
else
    LOG_FILE="puppet_access_ssl.log"
fi

# total number of times the GET_URL was fetched
FETCHED_TOTAL=$(grep -c $GET_URL $LOG_FILE)

# number of return codes other than 200 when fetching the GET_URL
FETCHED_NOT_200=$(grep $GET_URL $LOG_FILE | awk '{print $9}' | grep -vc 200)

# total number of times Apache returned ANY code other than 200
TOTAL_NON_200=$(grep -v ^$ $LOG_FILE | awk '{print $9}' | grep -vc 200)

# total number of PUT requests to the PUT_URL
PUT_REQ=$(grep -c "PUT $PUT_URL" $LOG_FILE)

# number of requests per IP sent as PUT requests to the PUT_URL 
PUT_BREAKDOWN=$(grep "PUT $PUT_URL" $LOG_FILE | awk '{print $1}' | uniq -c | sort -nr)


### Outputting data...
echo "################################################"
echo "### Log file analysis for $LOG_FILE"
echo "################################################"
echo "================================================"
echo "Stats for URL: $GET_URL"
echo "  - times fetched: $FETCHED_TOTAL"
echo "  - failed/(non-200 status): $FETCHED_NOT_200"
echo "================================================"
echo "Total number of non-200 status codes in log: $TOTAL_NON_200"
echo "================================================"
echo "Stats for URL: $PUT_URL"
echo "  - total PUT requests: $PUT_REQ"
echo "  - breakdown of PUT requests by IP (req number/IP):"
echo "$PUT_BREAKDOWN"
echo "================================================"
echo "################################################"
