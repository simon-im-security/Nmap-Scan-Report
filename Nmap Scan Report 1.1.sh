#!/bin/bash

# Banner
echo "-----------------------------------------"
echo "           Nmap Scan Report              "
echo "-----------------------------------------"
echo "Description: This script performs a comprehensive port scan using Nmap, gathering detailed information about open ports and services on the target system."
echo "It generates an HTML report for easy analysis and provides the option to explore additional information on macOS ports used by Apple."
echo "Version: 1.1"
echo "Made by Simon Im"
echo "Date: 19th March 2024"
echo "-----------------------------------------"

# Check if Nmap binary is installed
if ! command -v nmap &> /dev/null; then
    echo "Nmap is not installed. You can download it from https://nmap.org/download"
    read -p "Would you like to open the Nmap website to download it? (yes/no): " choice
    if [[ $choice =~ ^[Yy](es)?$ ]]; then
        open "https://nmap.org/download"
    fi
    exit 1
fi

# Define the target IP address
target="127.0.0.1"

# Run Nmap scan with aggressive options and save results to XML
nmap -A -oX /private/tmp/port_scan_results.xml $target &&

# Check if the XML file is created successfully
if [ -e "/private/tmp/port_scan_results.xml" ]; then
    # Generate HTML report from XML
    xsltproc -o /private/tmp/port_scan_results.html /usr/local/bin/../share/nmap/nmap.xsl /private/tmp/port_scan_results.xml
    
    # Check if HTML report is created successfully
    if [ -e "/private/tmp/port_scan_results.html" ]; then
        echo "HTML report generated successfully."
    else
        echo "Error: HTML report generation failed."
    fi
else
    echo "Error: XML file not created."
fi

# Open the HTML report in the default web browser
open "/private/tmp/port_scan_results.html"

# Ask the user if they would like more information on macOS ports used by Apple
read -p "Would you like more information on macOS ports used by Apple? (yes/no): " choice
if [[ $choice =~ ^[Yy](es)?$ ]]; then
    open "https://support.apple.com/en-au/103229"
fi
