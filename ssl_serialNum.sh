#!/bin/bash

# This bash script uses openssl to connect to IP addresses and save the SSL Cert serial number associated with each IP
# The script will loop through a .txt file of IP's and save results to a .csv file
# Ensure script is executable - e.g. "chmod +x ssl_serialNum.sh"

# IP .txt file name - If file is not in same directory as script, ensure you have the path to the file included
input_file="ip_addresses.txt"

# Name of the .csv file - File will be saved in same directory as script.
output_file="certificate_info.csv"

echo "IP Address,Serial Number" > "$output_file"

while IFS= read -r ip_address; do
  echo "Processing IP address: $ip_address"

  # Retrieve the serial number or handle the error
  serial_number=$(echo | openssl s_client -showcerts -servername "$ip_address" -connect "$ip_address":443 2>/dev/null | openssl x509 -inform pem -noout -serial 2>&1 | cut -d'=' -f2)
  if [[ $serial_number == *"unable to load certificate"* ]]; then
    serial_number="IP Address did not resolve to anything"
  fi

  # Append the data to the CSV file
  echo "$ip_address,$serial_number" >> "$output_file"
done < "$input_file"

echo "Certificate information saved to $output_file"
