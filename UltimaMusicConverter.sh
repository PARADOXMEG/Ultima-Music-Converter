#!/bin/bash

# --- Setup & Colors ---
ESC=$(printf '\033')
RESET="${ESC}[0m"
CYAN="${ESC}[96m"
GREEN="${ESC}[92m"
YELLOW="${ESC}[93m"
GRAY="${ESC}[90m"
WHITE="${ESC}[97m"
RED="${ESC}[91m"

show_menu() {
    clear
    echo -e "${CYAN}╔═════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}║${RESET}                   ${GREEN}${ESC}[1mULTIMA MUSIC CONVERTER${RESET}                    ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}                     (Powered by ffmpeg)                     ${CYAN}║${RESET}"
    echo -e "${CYAN}╠═════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "${CYAN}║${RESET} ${WHITE}Select the conversion type you want to perform:${RESET}             ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}                                                             ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}  ${YELLOW}1.${RESET} FLAC to MP3    ${GRAY}(Max Quality: 320kbps CBR)${RESET}               ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}  ${YELLOW}2.${RESET} FLAC to M4A    ${GRAY}(Max Quality: 320kbps AAC)${RESET}               ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}  ${YELLOW}3.${RESET} FLAC to Opus   ${GRAY}(Max Quality: 320kbps)${RESET}                   ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}  ${YELLOW}4.${RESET} MP3 to Opus    ${GRAY}(Max Quality: 320kbps)${RESET}                   ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}  ${YELLOW}5.${RESET} MP3 to M4A     ${GRAY}(Max Quality: 320kbps AAC)${RESET}               ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}  ${YELLOW}6.${RESET} M4A to MP3     ${GRAY}(Max Quality: 320kbps CBR)${RESET}               ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}  ${YELLOW}7.${RESET} M4A to Opus    ${GRAY}(Max Quality: 320kbps)${RESET}                   ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}  ${YELLOW}8.${RESET} Opus to M4A    ${GRAY}(Max Quality: 320kbps AAC)${RESET}               ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET}  ${YELLOW}9.${RESET} Opus to MP3    ${GRAY}(Max Quality: 320kbps CBR)${RESET}               ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET} ${YELLOW}10.${RESET} MP3 to FLAC    ${GRAY}(Lossless wrapping)${RESET}                      ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET} ${YELLOW}11.${RESET} Opus to FLAC   ${GRAY}(Lossless wrapping)${RESET}                      ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET} ${YELLOW}12.${RESET} M4A to FLAC    ${GRAY}(Lossless wrapping)${RESET}                      ${CYAN}║${RESET}"
    echo -e "${CYAN}╚═════════════════════════════════════════════════════════════╝${RESET}"
    echo
}

show_menu
read -p "${WHITE}Enter your choice (1-12): ${RESET}" choice

# --- Define Codecs ---
case $choice in
    1)  SRC="flac"; DST="mp3";  CODEC="-map 0:a -map 0:v? -c:v copy -map_metadata 0 -id3v2_version 3 -c:a libmp3lame -b:a 320k" ;;
    2)  SRC="flac"; DST="m4a";  CODEC="-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a aac -b:a 320k" ;;
    3)  SRC="flac"; DST="opus"; CODEC="-map 0:a -map_metadata 0 -c:a libopus -b:a 320k" ;;
    4)  SRC="mp3";  DST="opus"; CODEC="-map 0:a -map_metadata 0 -c:a libopus -b:a 320k" ;;
    5)  SRC="mp3";  DST="m4a";  CODEC="-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a aac -b:a 320k" ;;
    6)  SRC="m4a";  DST="mp3";  CODEC="-map 0:a -map 0:v? -c:v copy -map_metadata 0 -id3v2_version 3 -c:a libmp3lame -b:a 320k" ;;
    7)  SRC="m4a";  DST="opus"; CODEC="-map 0:a -map_metadata 0 -c:a libopus -b:a 320k" ;;
    8)  SRC="opus"; DST="m4a";  CODEC="-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a aac -b:a 320k" ;;
    9)  SRC="opus"; DST="mp3";  CODEC="-map 0:a -map 0:v? -c:v copy -map_metadata 0 -id3v2_version 3 -c:a libmp3lame -b:a 320k" ;;
    10) SRC="mp3";  DST="flac"; CODEC="-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a flac" ;;
    11) SRC="opus"; DST="flac"; CODEC="-map 0:a -map 0:v? -c:v copy -map_metadata 0 -c:a flac" ;;
    12) SRC="m4a";  DST="flac"; CODEC="-map 0:a -map_metadata 0 -c:a flac" ;;
    *)  echo -e "${RED}[!] Invalid choice.${RESET}"; sleep 2; exec "$0" ;;
esac

echo
read -p "${WHITE}Enter number of parallel tasks (1-5): ${RESET}" MAX_THREADS
[[ ! $MAX_THREADS =~ ^[1-5]$ ]] && MAX_THREADS=2

echo
read -p "${WHITE}Enter target directory path (leave blank for current): ${RESET}" TARGET_DIR
TARGET_DIR="${TARGET_DIR:-$(pwd)}"

# --- Key Fixes for Churn ---
# 1. Recursive search: removed "-maxdepth 1" to look inside folders[cite: 1]
# 2. Case Insensitivity: "-iname" instead of "-name" catches .MP3 and .mp3[cite: 1]
# 3. Null Delimiters: Handles spaces and Japanese characters correctly[cite: 1]
TOTAL_FILES=$(find "$TARGET_DIR" -type f -iname "*.$SRC" | wc -l)

if [ "$TOTAL_FILES" -eq 0 ]; then
    echo -e "${RED}[!] Error: No .$SRC files found in $TARGET_DIR (checked subfolders too).${RESET}"
    exit 1
fi

clear
echo -e "${CYAN}╔═════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}║${RESET}  ${GREEN}${ESC}[1mSTARTING PARALLEL CONVERSION:${RESET} ${WHITE}.${SRC} --> .${DST}${RESET}             ${CYAN}║${RESET}"
echo -e "${CYAN}║${RESET}  ${GRAY}Target: \"$TARGET_DIR\"${RESET}"
echo -e "${CYAN}║${RESET}  ${GRAY}Files: $TOTAL_FILES   |   Max Threads: $MAX_THREADS${RESET}"
echo -e "${CYAN}╚═════════════════════════════════════════════════════════════╝${RESET}"

export CODEC DST SRC GREEN RED RESET

convert_file() {
    infile="$1"
    outfile="${infile%.*}.$DST"
    
    if ffmpeg -y -v error -i "$infile" $CODEC "$outfile" > /dev/null 2>&1; then
        rm "$infile"
        echo -e "${GREEN}[DONE]${RESET} ${infile##*/}"
    else
        echo -e "${RED}[FAIL]${RESET} ${infile##*/}"
    fi
}
export -f convert_file

# Execution engine[cite: 1]
find "$TARGET_DIR" -type f -iname "*.$SRC" -print0 | xargs -0 -I {} -P "$MAX_THREADS" bash -c 'convert_file "$@"' _ {}

echo -e "\n${CYAN}═══════════════════════════════════════════════════════════════${RESET}"
echo -e "${GREEN}[SUCCESS] All $TOTAL_FILES files processed.${RESET}"