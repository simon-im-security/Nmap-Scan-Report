# Nmap Scan Report

## Description:
Nmap Scan Report is a bash script that conducts thorough port scans using Nmap, revealing open ports and services on a target system. It then generates a detailed HTML report for analysis, helping network administrators and security professionals identify potential vulnerabilities and strengthen network defenses.

## Features:
- Conducts targeted Nmap scans including TCP Connect, ICMP Ping, and Service Version Detection.
- Generates detailed HTML reports illustrating discovered open ports and services.
- Provides options to scan either the local machine (loopback) or specify an IP range using CIDR notation.
- While focusing on TCP Connect and ICMP Ping scans, it offers comprehensive insights into detected services and open ports, enhancing network visibility and security analysis.

## Screenshot:
![Nmap Scan Report](https://github.com/simon-im-security/Nmap-Scan-Report/raw/main/nmap-scan-report-image.png)

## Dependencies:
- **Nmap Binary:** The script requires the Nmap tool to conduct port scanning. You can download Nmap from the official website [here](https://nmap.org/download).

## Usage:
To execute the script, you can use the following one-liner command:

**Mac**
```bash
curl -o /private/tmp/nmap_scan_report.sh https://raw.githubusercontent.com/simon-im-security/Nmap-Scan-Report/main/Nmap%20Scan%20Report_Mac.sh && chmod +x /private/tmp/nmap_scan_report.sh && /private/tmp/nmap_scan_report.sh
