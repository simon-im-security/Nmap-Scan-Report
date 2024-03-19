# Nmap Scan Report

## Description:
Nmap Scan Report is a bash script designed to conduct a comprehensive port scan and produce a detailed report of open ports and services running on a target system. The script utilizes the Nmap tool to perform the scan and generates an HTML report for further analysis.

## Features:
- Conducts a thorough port scan using Nmap.
- Generates an HTML report with detailed information about open ports and services.
- Provides an option to explore additional information on macOS ports used by Apple.

## Screenshot:
![Nmap Scan Report](https://github.com/simon-im-security/Nmap-Scan-Report/raw/main/nmap-scan-report-image.png)

## Dependencies:
- **Nmap Binary:** The script requires the Nmap tool to conduct port scanning. You can download Nmap from the official website [here](https://nmap.org/download).

## Usage:
To execute the script, you can use the following one-liner command:

**Mac**
```bash
curl -o /private/tmp/nmap_scan_report.sh https://raw.githubusercontent.com/simon-im-security/Nmap-Scan-Report/main/Nmap%20Scan%20Report_Mac.sh && chmod +x /private/tmp/nmap_scan_report.sh && /private/tmp/nmap_scan_report.sh
