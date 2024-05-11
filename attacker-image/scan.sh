#!/bin/bash

tempvar=$(nmap $1 -F -oN result.txt)

input_file="result.txt"  # Replace with your Nmap output file
output_file="open_ports.csv"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "No Input File Was Found!"
    exit 1
fi

# Check the Nmap output file and extract host, port, and state info 
awk '/Nmap scan report for/{ip=$NF} /^[0-9]+\/tcp/{print ip "," $1 "," $2}' "$input_file" > "$output_file"
echo "Conversion completed successfully. The results were saved to the $output_file."

