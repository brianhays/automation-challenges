## Description

scrape_it.sh will scrape Apache's "common" format logs for the following items:
* How many times the URL (set as: GET_URL) was fetched
 * ...of the above requests, how many return codes other than 200
* The total number of times Apache returned ANY code other than 200
* The number of times that an IP address sent a PUT request to a path (set as: PATH_URL)
 * ...a breakdown of how many times such requests were made by IP address

## Usage Instructions
You may either clone the project or copy the scrape_it.sh file to any *nix-based system (Mac OSX included of course). The script will assume that a logfile named "puppet_access_ssl.log" resides in the same directory, however you can also pass a file name as an argument when running the script (such as: "sh scrape_it.sh myfile.log") - optional log file should be in apache common log format)

run the script via:
    sh scrape_it.sh

or (with different log file):
    sh scrape_it.sh /var/log/httpd/access_log