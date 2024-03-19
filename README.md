# Nmap Scan Report

## Description:
Nmap Scan Report is a bash script that conducts a comprehensive port scan and produces a detailed report of open ports and services running on a target system. The script utilizes the Nmap tool to perform the scan and generates an HTML report for further analysis.

## Features:
- Conducts a thorough port scan using Nmap.
- Generates an HTML report with detailed information about open ports and services.
- Provides an option to explore additional information on macOS ports used by Apple.

## Dependencies:
- **Nmap Binary:** The script requires the Nmap tool to conduct port scanning. You can download Nmap from the official website [here](https://nmap.org/download).

## Usage:
To execute the script, you can use the following one-liner command:

```bash
curl -o /private/tmp/nmap_scan_report.sh https://raw.githubusercontent.com/simon-im-security/Nmap-Scan-Report/main/Nmap%20Scan%20Report.sh && chmod +x /private/tmp/nmap_scan_report.sh && /private/tmp/nmap_scan_report.sh

