#!/bin/bash

# ==========================================
# SDGAMER MULTI-TOOL SCRIPT
# OWNER: SDGAMER
# GITHUB: sdgamer8263-sketch
# ==========================================

# Color Codes
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Typing Animation Function
type_effect() {
    local text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep 0.03
    done
    echo ""
}

# Function for Main Rainbow Banner
banner() {
    clear
    echo -e "${CYAN}╭──────────────────────────────────────────────────╮${NC}"
    echo -e "${CYAN}│${NC}${RED}  ____  ${GREEN}____   ${YELLOW}____    ${BLUE}_    ${PURPLE}__  ${CYAN}__ ${WHITE}_____ ${RED}____   ${NC}${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}${GREEN} / ___|${YELLOW}|  _ \ ${BLUE}/ ___|  ${PURPLE}/ \  ${CYAN}|  \/  ${WHITE}| ____|${RED}|  _ \  ${NC}${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}${YELLOW} \___ \|${BLUE} | | |${PURPLE} |  _  ${CYAN}/ _ \ |${WHITE} |\/| |${RED}  _| |${GREEN} |_) | ${NC}${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}${BLUE}  ___) |${PURPLE} |_| |${CYAN} |_| |${WHITE}/ ___ \|${RED} |  | |${GREEN} |___|${YELLOW}  _ <  ${NC}${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}${PURPLE} |____/|${CYAN}____/ ${WHITE}\____/_/${RED}   \_\_|${GREEN}  |_|${YELLOW}_____|${BLUE}_| \_\\ ${NC}${CYAN}│${NC}"
    echo -e "${CYAN}╰──────────────────────────────────────────────────╯${NC}"
    echo -e "      ${Y}⚡ ${WHITE}Owner: ${GREEN}SDGAMER ${Y}⚡ ${WHITE}GitHub: ${BLUE}sdgamer8263-sketch${NC}"
    echo ""
}

# Function for Playit.GG Neon Banner
playit_banner() {
    clear
    echo -e "${GREEN}╭──────────────────────────────────────────────────╮${NC}"
    echo -e "${GREEN}│${NC}${CYAN}  ____  _        _ __   ___ _____     ____  ____   ${NC}${GREEN}│${NC}"
    echo -e "${GREEN}│${NC}${CYAN} |  _ \| |      / \\ \ / /_ _|_   _|   / ___|/ ___|  ${NC}${GREEN}│${NC}"
    echo -e "${GREEN}│${NC}${CYAN} | |_) | |     / _ \\ \ / / | |  | |    | |  _| |  _   ${NC}${GREEN}│${NC}"
    echo -e "${GREEN}│${NC}${CYAN} |  __/| |___ / ___ \ | |  | |  | |    | |_| | |_| |  ${NC}${GREEN}│${NC}"
    echo -e "${GREEN}│${NC}${CYAN} |_|   |_____/_/   \_\_| |___| |_|     \____|\____|  ${NC}${GREEN}│${NC}"
    echo -e "${GREEN}╰──────────────────────────────────────────────────╯${NC}"
    echo -e "         ${YELLOW}⚡ PORT FORWARDING CONTROL CENTER ⚡${NC}"
    echo ""
}

# Playit.GG Submenu
playit_menu() {
    while true; do
        playit_banner
        echo -e "      ${WHITE}╔══════════════════════════════════╗${NC}"
        echo -e "      ${WHITE}║${NC}  ${GREEN}[A]${WHITE} INSTALL + SETUP PLAYIT    ${WHITE}║${NC}"
        echo -e "      ${WHITE}║${NC}  ${GREEN}[B]${WHITE} CHECK PLAYIT STATUS       ${WHITE}║${NC}"
        echo -e "      ${WHITE}║${NC}  ${RED}[C]${WHITE} BACK TO MAIN MENU         ${WHITE}║${NC}"
        echo -e "      ${WHITE}╚══════════════════════════════════╝${NC}"
        echo ""
        echo -en "${CYAN}  ➥ Choose an option: ${NC}"
        read -r subopt

        case $subopt in
            [Aa])
                echo -e "\n${YELLOW}🚀 Running Playit Setup...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/playit-ins)
                echo -e "\n${GREEN}✅ Task Finished! Press Enter...${NC}"; read -r ;;
            [Bb])
                echo -e "\n${CYAN}🔍 Checking Status...${NC}"
                playit
                echo -e "\n${RED}🛑 Invalid/Stopped. Press Enter to stay here...${NC}"; read -r ;;
            [Cc]) break ;;
            *) echo -e "${RED}❌ Invalid! Try A, B, or C.${NC}"; sleep 1 ;;
        esac
    done
}

# Main Loop
while true; do
    banner
    echo -e "   ${PURPLE}┌──────────────────────────────────────────────┐${NC}"
    echo -e "   ${PURPLE}│${NC}  ${CYAN}[01]${WHITE} VPS SETUP (VM1)                    ${NC}${PURPLE}│${NC}"
    echo -e "   ${PURPLE}│${NC}  ${CYAN}[02]${WHITE} PTERODACTYL PANEL                  ${NC}${PURPLE}│${NC}"
    echo -e "   ${PURPLE}│${NC}  ${CYAN}[03]${WHITE} WINGS SETUP                        ${NC}${PURPLE}│${NC}"
    echo -e "   ${PURPLE}│${NC}  ${CYAN}[04]${WHITE} TOOLER SCRIPT                      ${NC}${PURPLE}│${NC}"
    echo -e "   ${PURPLE}│${NC}  ${CYAN}[05]${WHITE} THEME INSTALLER                    ${NC}${PURPLE}│${NC}"
    echo -e "   ${PURPLE}│${NC}  ${CYAN}[06]${WHITE} NECESSARY TOOL (No KVM)            ${NC}${PURPLE}│${NC}"
    echo -e "   ${PURPLE}│${NC}  ${YELLOW}[07]${WHITE} PLAYIT.GG (Port Forwarding)        ${NC}${PURPLE}│${NC}"
    echo -e "   ${PURPLE}│${NC}  ${GREEN}[08]${WHITE} 24/7 CODE (Python)                 ${NC}${PURPLE}│${NC}"
    echo -e "   ${PURPLE}│${NC}  ${RED}[09]${WHITE} EXIT SYSTEM                        ${NC}${PURPLE}│${NC}"
    echo -e "   ${PURPLE}└──────────────────────────────────────────────┘${NC}"
    echo ""
    echo -en "${GREEN}  ⚡ Input your choice [1-9]: ${NC}"
    read -r mainopt

    case $mainopt in
        1|01) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/VPS/main/Vm1) ;;
        2|02) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh) ;;
        3|03) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Wings-setup/main/run.sh) ;;
        4|04) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/tooler/main/run.sh) ;;
        5|05) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/run.sh) ;;
        6|06) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/ee/main/run.sh) ;;
        7|07) playit_menu; continue ;;
        8|08) python3 <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/24-7/refs/heads/main/24) ;;
        9|09) 
            echo -e "\n${YELLOW}Thanks for using ${PURPLE}SDGAMER${YELLOW} Tool!${NC}"
            type_effect "Closing session... Goodbye!"
            exit 0 ;;
        *) echo -e "${RED}❌ Invalid selection! Try again.${NC}"; sleep 1.5; continue ;;
    esac

    # Global Wait
    echo -e "\n${CYAN}────────────────────────────────────────────────────${NC}"
    echo -e "${GREEN}✔ Action Completed Successfully!${NC}"
    echo -en "${WHITE}⌨ Press ${YELLOW}[ENTER]${WHITE} to go back to Home Menu...${NC}"
    read -r
done
