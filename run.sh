#!/bin/bash

# ==========================================
# SDGAMER MULTI-TOOL (BLOCKY EDITION)
# STYLE: INSPIRED BY CODING HUB
# ==========================================

# Color Palette
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
P='\033[1;35m'
C='\033[1;36m'
W='\033[1;37m'
NC='\033[0m'

# Function for 3D Blocky Colorful Banner
banner() {
    clear
    echo -e "${C}╭──────────────────────────────────────────────────────────╮${NC}"
    echo -e " ${R}  ____  ${G}____    ${Y}____   ${B}  _    ${P} __  __ ${C} _____ ${W} ____   "
    echo -e " ${R} / ___| ${G}|  _ \  ${Y}/ ___|  ${B} / \   ${P}|  \/  |${C}| ____|${W}|  _ \  "
    echo -e " ${R} \___ \ ${G}| | | | ${Y}|  _   ${B} / _ \  ${P}| |\/| |${C}|  _|  ${W}| |_) | "
    echo -e " ${R}  ___) |${G}| |_| | ${Y}| |_| | ${B}/ ___ \ ${P}| |  | |${C}| |___ ${W}|  _ <  "
    echo -e " ${R} |____/ ${G}|____/  ${Y}\____/ ${B}/_/   \_\ ${P}|_|  |_|${C}|_____|${W}|_| \_\ "
    echo -e "${C}╰──────────────────────────────────────────────────────────╯${NC}"
    echo -e "  ${G}HOST: SD-Server${NC}  ${W}│${NC}  ${Y}STATUS: Active${NC}  ${W}│${NC}  ${B}NET: Connected${NC}"
    echo ""
}

# Playit.GG Banner
playit_banner() {
    clear
    echo -e "${G}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e " ${C}  ____  _        _ __   ___ _____     ____  ____   ${NC}"
    echo -e " ${C} |  _ \| |      / \\ \ / /_ _|_   _|   / ___|/ ___|  ${NC}"
    echo -e " ${C} | |_) | |     / _ \\ \ / / | |  | |    | |  _| |  _   ${NC}"
    echo -e " ${C} |  __/| |___ / ___ \ | |  | |  | |    | |_| | |_| |  ${NC}"
    echo -e " ${C} |_|   |_____/_/   \_\_| |___| |_|     \____|\____|  ${NC}"
    echo -e "${G}╚══════════════════════════════════════════════════════════╝${NC}"
    echo -e "             ${Y}⚡ PLAYIT.GG PORT FORWARDING ⚡${NC}"
    echo ""
}

# Playit Submenu
playit_menu() {
    while true; do
        playit_banner
        echo -e "    ${W}» ${G}[A]${W} Install + Setup Playit"
        echo -e "    ${W}» ${G}[B]${W} Status Check"
        echo -e "    ${W}» ${R}[C]${W} Back to Menu"
        echo ""
        echo -en "${C} ➥ Input: ${NC}"
        read -r subopt
        case $subopt in
            [Aa]) bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/playit-ins); echo -e "\n${G}Done!${NC}"; read -r ;;
            [Bb]) playit; echo -e "\n${R}Back? Press Enter...${NC}"; read -r ;;
            [Cc]) break ;;
            *) echo -e "${R}Invalid!${NC}"; sleep 1 ;;
        esac
    done
}

# Main Application Loop
while true; do
    banner
    echo -e " ${B}🚀 DEPLOYMENT SERVICES${NC}"
    echo -e " ${C}──────────────────────────────────────────${NC}"
    echo -e "  ${G}[1]${W} Setup VPS                ${G}[5]${W} Theme Configurator"
    echo -e "  ${G}[2]${W} Pterodactyl Panel        ${G}[6]${W} System Tools (No KVM)"
    echo -e "  ${G}[3]${W} Wings Setup              ${G}[7]${W} Playit.GG Forwarding"
    echo -e "  ${G}[4]${W} Tooler Script            ${G}[8]${W} 24/7 Python Code"
    echo -e "  ${R}[9]${W} Exit Script"
    echo -e " ${C}──────────────────────────────────────────${NC}"
    echo ""
    echo -en "${Y} ⚡ Select Service: ${NC}"
    read -r mainopt

    case $mainopt in
        1|01) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/VPS/main/Environment) ;;
        2|02) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh) ;;
        3|03) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Wings-setup/main/run.sh) ;;
        4|04) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/tooler/main/run.sh) ;;
        5|05) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/run.sh) ;;
        6|06) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/ee/main/run.sh) ;;
        7|07) playit_menu; continue ;;
        8|08) python3 <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/24-7/refs/heads/main/24) ;;
        9|09) echo -e "\n${Y}Goodbye!${NC}"; exit 0 ;;
        *) echo -e "${R}Invalid!${NC}"; sleep 1 ;;
    esac

    echo -e "\n${G}✔ Operation Finished!${NC}"
    echo -en "${W}Press ${Y}[ENTER]${W} to return...${NC}"
    read -r
done
