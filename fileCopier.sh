#!/bin/bash

yellowColor='\033[1;33m'
redColor='\033[0;31m'
noColor='\033[0m'

copyFiles() {
    [[ "$#" -ne 3 ]] && echo "There are should be 3 arguments" && exit 1

    [[ -d "$1" ]] && DIR="$1" || { echo -e "Source directory (1 variable) is setted ${redColor}incorrectly${noColor}"; exit 2; }
    [[ -d "$2" ]] && DIR_TO="$2" || { echo -e "Destination directory (2 variable) is setted ${redColor}incorrectly${noColor}"; exit 2; }
    [[ $3 =~ ^[0-9]+$ ]] && N="$3" || { echo -e "Number (3 variable) is setted ${redColor}incorrectly${noColor}"; exit 2; }

    find "$DIR" -type f -exec du -h {} + | sort -rh | head -n "$N" | cut -f2- | xargs -I {} cp {} "$DIR_TO"

    echo "Copying from directory $DIR to directory $DIR_TO was successful"
}

scriptHelp() {
printf \
"${yellowColor}$0${noColor} script
Usage: $0 [OPTIONS] DIR DIR_TO N
Copy the N largest files from DIR to DIR_TO.
 
Options:
    -h, --help     Display this help message and exit.
 
Arguments:
    DIR            Source directory containing files to be copied.
    DIR_TO         Destination directory where files will be copied.
    N              Number of largest files to copy.\n"
    exit 0
}

[ "$1" == "-help" ] && scriptHelp || copyFiles "$@"
