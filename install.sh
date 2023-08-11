#!/bin/bash

echo -e "\033[2J\033[3;1f"

printf "\n\n\033[1;35mPerfomanceVPN ✨\033[0m"

echo -e "\n\n\033[0;96mInstalling base packages...\033[0m"

eval "apt update && apt upgrade"
