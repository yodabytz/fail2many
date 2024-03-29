#!/bin/bash
# Licensed under the MIT License.
# Copyright 2024 Yodabytz

threshold=3
declare -A offenders
banned_ips=0

# Function to check if an IP already exists in fail2many.txt
ip_exists() {
    local ip=$1
    if grep -q "^$ip$" /etc/fail2many.txt; then
        return 0  # IP exists
    else
        return 1  # IP does not exist
    fi
}

# Function to process log files
process_log_file() {
    local log_file=$1
    while read -r line; do
        if grep -q 'Ban' <<< "$line"; then
            ip_address=$(awk '{print $8}' <<< "$line")  # Adjusted to extract the IP address correctly
            if [ "$ip_address" != "Ban" ]; then
                offenders["$ip_address"]=$((${offenders["$ip_address"]:-0} + 1))

                if [ ${offenders["$ip_address"]} -ge $threshold ]; then
                    if ! ip_exists "$ip_address"; then
                        echo $ip_address >> /etc/fail2many.txt
                        ((banned_ips++))
                    fi
                fi
            fi
        fi
    done < "$log_file"
}

# Process the primary log file
process_log_file "/var/log/fail2ban.log"

# Process the rotated log file
process_log_file "/var/log/fail2ban.log.1"

if [ $banned_ips -gt 0 ]; then
    echo "Added $banned_ips IPs to /etc/fail2many.txt"
else
    echo "No IPs were added"
fi
