#!/bin/bash

# This bash script uses openssl to connect to domain names, resolves them to IPs using dig, 
# and save the SSL Cert serial number associated with each domain.
# The script will loop through a .txt file of domain names and save results to a .csv file.
# Ensure script is executable - e.g. "chmod +x ssl_serialNum.sh"

# Domain .txt file name - If file is not in same directory as script, ensure you have the path to the file included
input_file="ip_addresses.txt"

# Name of the .csv file - File will be saved in the same directory as the script.
output_file="certificate_info.csv"

echo "Domain Name,IP Address (A Record),CNAME Record,Serial Number" > "$output_file"

while IFS= read -r domain_name; do
  echo "Processing domain name: $domain_name"

  # Extract the A record using dig
  ip_address=$(dig +short "$domain_name" A | tr '\n' ';' | sed 's/;$//')

  # Extract the CNAME record using dig
  cname_record=$(dig +short "$domain_name" CNAME | tr -d '\n')

  # If no IP is found, use the first A record if available, else annotate accordingly
  if [ -z "$ip_address" ]; then
    first_ip="No A Record Found"
  else
    first_ip=$(echo $ip_address | cut -d';' -f1)
  fi

  # Retrieve the serial number or handle the error
  serial_number=$(echo | openssl s_client -showcerts -servername "$domain_name" -connect "$first_ip":443 2>/dev/null | openssl x509 -inform pem -noout -serial 2>&1 | cut -d'=' -f2)
  
  if [[ $serial_number == *"unable to load certificate"* ]]; then
    serial_number="Domain did not resolve to a valid SSL certificate"
  fi

  # Append the data to the CSV file
  echo "$domain_name,\"$ip_address\",\"$cname_record\",\"$serial_number\"" >> "$output_file"
done < "$input_file"
