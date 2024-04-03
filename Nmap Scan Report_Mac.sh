#!/bin/bash

# Banner
echo "-----------------------------------------"
echo "           Nmap Scan Report              "
echo "-----------------------------------------"
echo "Description: This script performs a comprehensive port scan using Nmap, gathering detailed information about open ports and services on the target system."
echo "It generates an HTML report for easy analysis and provides the option to explore additional information on macOS ports used by Apple."
echo "Version: 2.2"
echo "Made by Simon Im"
echo "Date: 3rd April 2024"
echo "-----------------------------------------"

# Function to display error message and exit
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Function to check if the user has root privileges
check_root_privileges() {
    if [ "$(id -u)" != "0" ]; then
        echo "This script requires root privileges to perform TCP SYN, UDP, and OS detection scans."
        exit 1
    fi
}

# Check if Nmap binary is installed
if ! command -v nmap &> /dev/null; then
    error_exit "Nmap is not installed. You can download it from https://nmap.org/download"
fi

# Check if xsltproc is installed
if ! command -v xsltproc &> /dev/null; then
    error_exit "xsltproc is not installed. You need to install it to generate HTML reports."
fi

# Prompt user to choose between loopback or IP range
echo "Choose an option:"
echo "1. Scan the local machine (loopback)"
echo "2. Specify an IP range (CIDR notation)"
echo "0. Exit"
read -p "Enter your choice: " choice

case $choice in
    1)
        target="127.0.0.1"
        
        # Check if the system is macOS
        if [ "$(uname)" == "Darwin" ]; then
            # Ask the user if they would like more information on macOS ports used by Apple
            read -p "Before scanning, would you like more information on macOS ports used by Apple? (yes/no): " apple_choice
            # Convert the user input to lowercase for case-insensitive comparison
            apple_choice_lowercase=$(echo "$apple_choice" | tr '[:upper:]' '[:lower:]')
            if [[ $apple_choice_lowercase =~ ^[y](es)?$ ]]; then
                open "https://support.apple.com/en-au/103229"
            fi
        fi
        ;;
    2)
        read -p "Enter the IP range to scan in CIDR notation (e.g., 192.168.1.0/24): " target
        ;;
    0)
        echo "Exiting the script."
        exit 0
        ;;
    *)
        error_exit "Invalid choice. Please choose 1, 2, or 0."
        ;;
esac

# Prompt user to choose Nmap scan type
while true; do
    echo "Choose Nmap scan type:"
    echo "1. TCP SYN scan (requires root)"
    echo "2. UDP scan (requires root)"
    echo "3. Version detection"
    echo "4. OS detection (requires root)"
    echo "0. All (default, requires root)"
    echo "9. Exit"
    read -p "Enter your choice: " scan_choice

    case $scan_choice in
        1)
            scan_type="-sS"
            # Check if the user has root privileges for TCP SYN scan
            check_root_privileges
            break
            ;;
        2)
            scan_type="-sU"
            # Check if the user has root privileges for UDP scan
            check_root_privileges
            break
            ;;
        3)
            scan_type="-sV"
            break
            ;;
        4)
            scan_type="-O"
            # Check if the user has root privileges for OS detection scan
            check_root_privileges
            break
            ;;
        0)
            # Check if the user has root privileges for any of the scans in the "All" option
            check_root_privileges
            scan_type="-sS -sU -sV -O"
            break
            ;;
        9)
            echo "Exiting the script."
            exit 0
            ;;
        *)
            if [[ -z $scan_choice ]]; then
                echo "Invalid input. Please try again."
            else
                echo "Invalid choice. Please enter a valid option."
            fi
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
