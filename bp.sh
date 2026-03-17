cat << 'EOF' > /root/rclone_menu.sh
#!/bin/bash

# ==========================================
# SKA HOST (SDGAMER) - AUTO CLOUD MANAGER
# ==========================================
LOCAL_DIR="/root/pterodactyl_backups"
GDRIVE_REMOTE="gdrive:pterodactyl/backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
SCRIPT_PATH=$(realpath "$0")

# 🧠 AUTO-FETCH DATABASE CREDENTIALS
ENV_FILE="/var/www/pterodactyl/.env"
if [ -f "$ENV_FILE" ]; then
    DB_USER=$(grep -w "DB_USERNAME" "$ENV_FILE" | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    DB_PASS=$(grep -w "DB_PASSWORD" "$ENV_FILE" | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    DB_NAME=$(grep -w "DB_DATABASE" "$ENV_FILE" | cut -d '=' -f2 | tr -d '"' | tr -d "'")
else
    echo "❌ ERROR: /var/www/pterodactyl/.env file nahi mili!"
    exit 1
fi

show_banner() {
    clear
    echo -e "\e[1;36m"
    echo "  ██████╗ ██████╗  ██████╗  █████╗ ███╗   ███╗███████╗██████╗ "
    echo " ██╔════╝ ██╔══██╗██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔══██╗"
    echo " ╚█████╗  ██║  ██║██║  ███╗███████║██╔████╔██║█████╗  ██████╔╝"
    echo "  ╚═══██╗ ██║  ██║██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ██╔══██╗"
    echo " ██████╔╝ ██████╔╝╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗██║  ██║"
    echo " ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"
    echo "              SKA HOST (SDGAMER) MANAGER                     "
    echo -e "\e[0m"
}

pause_to_continue() {
    echo ""
    read -p "Press Enter to continue..."
}

setup_env() {
    mkdir -p "$LOCAL_DIR"
    if ! command -v rclone &> /dev/null; then
        echo "⏳ Installing rclone for Google Drive..."
        curl https://rclone.org/install.sh | sudo bash
    fi
    if ! rclone listremotes | grep -q "gdrive:"; then
        clear
        echo "=========================================="
        echo "🔐 GOOGLE DRIVE SETUP REQUIRED"
        echo "=========================================="
        echo "1. 'n' press karo (New remote) aur naam 'gdrive' do."
        echo "2. Storage type mein 'drive' select karo."
        echo "3. Baaki sab default (Enter marte jao)."
        echo "4. Use auto config ke liye 'n' dabao aur code paste karo."
        pause_to_continue
        rclone config
    fi
    rclone mkdir "$GDRIVE_REMOTE" 2>/dev/null
}

# --- CRON AUTO BACKUP TASK ---
if [ "$1" == "auto" ]; then
    setup_env
    mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$LOCAL_DIR/panel_db_$DATE.sql"
    tar -czf "$LOCAL_DIR/panel_files_$DATE.tar.gz" -C /var/www/ pterodactyl
    tar -czf "$LOCAL_DIR/wings_config_$DATE.tar.gz" -C /etc/ pterodactyl
    rclone copy "$LOCAL_DIR" "$GDRIVE_REMOTE"
    find "$LOCAL_DIR" -type f -mtime +2 -exec rm {} \;
    exit 0
fi

# --- MANUAL BACKUP ---
backup_panel() {
    show_banner
    echo "📦 BACKING UP PANEL TO G-DRIVE..."
    mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$LOCAL_DIR/panel_db_$DATE.sql"
    tar -czf "$LOCAL_DIR/panel_files_$DATE.tar.gz" -C /var/www/ pterodactyl
    rclone copy "$LOCAL_DIR/panel_db_$DATE.sql" "$GDRIVE_REMOTE"
    rclone copy "$LOCAL_DIR/panel_files_$DATE.tar.gz" "$GDRIVE_REMOTE"
    echo "✅ Panel Backup Uploaded!"
    pause_to_continue
    main_menu
}

backup_wings() {
    show_banner
    echo "⚙️ BACKING UP WINGS TO G-DRIVE..."
    tar -czf "$LOCAL_DIR/wings_config_$DATE.tar.gz" -C /etc/ pterodactyl
    rclone copy "$LOCAL_DIR/wings_config_$DATE.tar.gz" "$GDRIVE_REMOTE"
    echo "✅ Wings Backup Uploaded!"
    pause_to_continue
    main_menu
}

# --- CLEAN RESTORE FUNCTIONS ---
restore_panel() {
    show_banner
    echo "♻️ IMPORT PANEL FROM G-DRIVE (CLEAN RESTORE)"
    rclone ls "$GDRIVE_REMOTE" | grep "panel_"
    echo ""
    read -p "Enter Database filename to import (or press Enter to skip): " db_file
    if [[ -n "$db_file" ]]; then
        rclone copy "$GDRIVE_REMOTE/$db_file" "$LOCAL_DIR"
        mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$LOCAL_DIR/$db_file"
        echo "✅ Database Restored (Old tables overwritten)!"
    fi
    echo ""
    read -p "Enter Panel Files filename (tar.gz) to import: " panel_file
    if [[ -n "$panel_file" ]]; then
        rclone copy "$GDRIVE_REMOTE/$panel_file" "$LOCAL_DIR"
        echo "🗑️ Deleting old Panel files for a clean start..."
        rm -rf /var/www/pterodactyl
        echo "📦 Extracting new backup..."
        tar -xzf "$LOCAL_DIR/$panel_file" -C /var/www/
        echo "✅ Panel Files Fully Restored!"
    fi
    pause_to_continue
    main_menu
}

restore_wings() {
    show_banner
    echo "♻️ IMPORT WINGS FROM G-DRIVE (CLEAN RESTORE)"
    rclone ls "$GDRIVE_REMOTE" | grep "wings_"
    echo ""
    read -p "Enter Wings filename (tar.gz) to import: " wings_file
    if [[ -n "$wings_file" ]]; then
        rclone copy "$GDRIVE_REMOTE/$wings_file" "$LOCAL_DIR"
        echo "🗑️ Deleting old Wings config for a clean start..."
        rm -rf /etc/pterodactyl
        echo "⚙️ Extracting new backup..."
        tar -xzf "$LOCAL_DIR/$wings_file" -C /etc/
        systemctl restart wings
        echo "✅ Wings Config Restored and Restarted!"
    fi
    pause_to_continue
    main_menu
}

setup_cron() {
    show_banner
    crontab -l 2>/dev/null | grep -v "$SCRIPT_PATH auto" > /tmp/current_cron
    echo "0 0 * * * $SCRIPT_PATH auto > /root/auto_backup.log 2>&1" >> /tmp/current_cron
    crontab /tmp/current_cron
    rm /tmp/current_cron
    echo "✅ Auto Backup enabled! Data will sync to Google Drive every 24 hours."
    pause_to_continue
    main_menu
}

main_menu() {
    setup_env
    show_banner
    echo "=========================================="
    echo "               📦 BACKUP                  "
    echo "=========================================="
    echo "1. Backup Panel (DB + Files) to G-Drive"
    echo "2. Backup Wings Config to G-Drive"
    echo "=========================================="
    echo "               ♻️ IMPORT                  "
    echo "=========================================="
    echo "3. Import Panel Data from G-Drive"
    echo "4. Import Wings Data from G-Drive"
    echo "=========================================="
    echo "               ⏰ AUTOMATION              "
    echo "=========================================="
    echo "5. Enable 24-Hour Auto Backup (Cron)"
    echo "6. ❌ Exit"
    echo "=========================================="
    read -p "Select an option (1-6): " choice
    case $choice in
        1) backup_panel ;;
        2) backup_wings ;;
        3) restore_panel ;;
        4) restore_wings ;;
        5) setup_cron ;;
        6) clear; exit 0 ;;
        *) main_menu ;;
    esac
}

main_menu
EOF

chmod +x /root/rclone_menu.sh
clear
/root/rclone_menu.sh

