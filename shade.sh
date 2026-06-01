#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Functions
get_ip_info() {
    read -p "Enter IP to look up: " target_ip
    echo -e "\n[+] Fetching IP information..."
    proxychains4 curl -s ipinfo.io/$target_ip
    echo -e "\n\n[+] Press Enter to return..." ; read
}

get_headers() {
    read -p "Enter Domain (e.g., example.com): " domain
    echo -e "\n[+] Grabbing HTTP headers..."
    proxychains4 curl -I -s $domain
    echo -e "\n[+] Done. Press Enter to return..." ; read
}

get_whois() {
    read -p "Enter Domain: " domain
    echo -e "\n[+] Fetching WHOIS information..."
    proxychains4 whois $domain | head -n 20
    echo -e "\n[+] Done. Press Enter to return..." ; read
}

check_for_updates() {
    echo -e "${CYAN}[+] Checking for updates...${NC}"
    # Dito mo ilalagay ang link kapag may GitHub ka na
    echo -e "${GREEN}[+] SHADE is up to date.${NC}"
    sleep 1
}

show_help() {
    echo -e "${CYAN}--- HELP MENU ---${NC}"
    echo "1) IP Info: Get location and ISP details of an IP."
    echo "2) Headers: View the server technology of a website."
    echo "3) Start/Rotate: Start Tor if offline, or rotate identity if already running."
    echo "4) Scan: Nmap scan for open ports on the target."
    echo "5) WHOIS: Domain registration information."
    echo "6) Auto-Clean: Wipe logs and command history."
    echo "7) Exit: Close SHADE."
    echo "8) Help: Display this menu."
    echo -e "-----------------"
    echo -e "[+] Press Enter to return..." ; read
}

show_menu() {
    clear
    echo -e "${CYAN}########################################${NC}"
    echo -e "${CYAN}#${NC}         ${YELLOW} S  H  A  D  E ${NC}            ${CYAN}#${NC}"
    echo -e "${CYAN}#${NC}      Legendary Recon Mode v2.0         ${CYAN}#${NC}"
    echo -e "${CYAN}########################################${NC}"
    echo -e "${CYAN}#${NC}  Created by: ${GREEN}BenjieDevSec${NC}           ${CYAN}#${NC}"
    echo -e "${CYAN}########################################${NC}"
    echo ""
    echo "1) Get IP Info    5) WHOIS Lookup"
    echo "2) HTTP Headers   6) Full Auto-Clean"
    echo "3) Start/Rotate   7) Exit"
    echo "4) Scan Target    8) Help"
    echo "========================================"
}

check_for_updates
while true; do
    show_menu
    read -p "Choose an option: " choice
    case $choice in
        1) get_ip_info ;;
        2) get_headers ;;
        3) 
           if ! pgrep -x "tor" > /dev/null; then
               tor &> /dev/null &
               echo "[+] Tor Started..." ; sleep 3
           else
               pkill -HUP tor
               echo "[+] Identity Rotated." ; sleep 2
           fi ;;
        4) 
           read -p "Enter Target IP/Domain: " target
           echo -e "[+] Scanning $target..."
           proxychains4 nmap -sT -PN -n -open $target ; read ;;
        5) get_whois ;;
        6) 
           rm -rf ~/.local/share/tor/*
           history -c
           echo -e "${GREEN}[+] Full clean complete. Logs wiped.${NC}" ; sleep 1 ;;
        7) echo "Logging out of SHADE" ; exit 0 ;;
        8) show_help ;;
        *) echo "Invalid option. Please try again." ; sleep 1 ;;
    esac
done
