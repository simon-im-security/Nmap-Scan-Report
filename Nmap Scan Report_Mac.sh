#!/bin/bash

# Banner
echo "-----------------------------------------"
echo "           Nmap Scan Report              "
echo "-----------------------------------------"
echo "Description: This script allows you to perform various Nmap scans, including a TCP connect scan, a basic ping scan, and version detection."
echo "Version: 2.3"
echo "Made by Simon Im"
echo "Date: 3rd April 2024"
echo "-----------------------------------------"

# Function to display error message and exit
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Check if Nmap binary is installed
if ! command -v nmap &> /dev/null; then
    error_exit "Nmap is not installed. You can download it from https://nmap.org/download"
fi

# Check if xsltproc is installed
if ! command -v xsltproc &> /dev/null; then
    error_exit "xsltproc is not installed. You need to install it to generate HTML reports."
fi

# Function to display scan description
display_scan_description() {
    case $1 in
        1)
            echo "1. TCP Connect Scan"
            echo "   Description: This scan establishes a full TCP connection to the target ports."
            ;;
        2)
            echo "2. Basic Ping Scan"
            echo "   Description: This scan determines which hosts are online by sending ICMP echo requests (pings)."
            ;;
        3)
            echo "3. Version detection"
            echo "   Description: This scan detects versions of services running on open ports."
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac
}

# Prompt user to choose between loopback or IP range
while true; do
    echo "Choose an option:"
    echo "1. Scan the local machine (loopback)"
    echo "2. Specify an IP range (CIDR notation)"
    echo "0. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            target="127.0.0.1"
            break
            ;;
        2)
            while true; do
                read -p "Enter the IP range to scan in CIDR notation (e.g., 192.168.1.0/24): " target
                if [ -z "$target" ]; then
                    echo "CIDR range cannot be empty. Please provide a valid CIDR range."
                else
                    break
                fi
            done
            break
            ;;
        0)
            echo "Exiting the script."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please choose 1, 2, or 0."
            ;;
    esac
done

# Prompt user to choose Nmap scan type
while true; do
    echo "Choose Nmap scan type:"
    display_scan_description 1
    echo ""
    display_scan_description 2
    echo ""
    display_scan_description 3
    echo ""
    echo "0. Exit"
    read -p "Enter your choice: " scan_choice

    case $scan_choice in
        1)
            scan_type="-sT"
            break
            ;;
        2)
            scan_type="-sn"
            break
            ;;
        3)
            scan_type="-sV"
            break
            ;;
        0)
            echo "Exiting the script."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac
done

# Run Nmap scan for the input target and save results to XML
if ! nmap $scan_type -A -oX "/private/tmp/port_scan_results.xml" $target; then
    error_exit "Nmap scan failed."
fi

# Check if the XML file is created successfully
if [ ! -e "/private/tmp/port_scan_results.xml" ]; then
    error_exit "XML file not created."
fi

# Generate HTML report from XML
if ! xsltproc -o "/private/tmp/port_scan_results.html" /usr/local/bin/../share/nmap/nmap.xsl "/private/tmp/port_scan_results.xml"; then
    error_exit "HTML report generation failed."
fi

# Check if HTML report is created successfully
if [ ! -e "/private/tmp/port_scan_results.html" ]; then
    error_exit "HTML report not created."
fi

echo "HTML report generated successfully."

# Open the HTML report in the default web browser
open "/private/tmp/port_scan_results.html" || error_exit "Failed to open HTML report."
