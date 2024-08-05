#!/bin/bash

. ./scripts/logger.sh


to_upper() {
  echo "$1" | tr '[:lower:]' '[:upper:]'
}


create_or_overwrite_file() {
    local source_file="$1"
    local target_file="$2"

    if [ -f "$target_file" ]; then
        read -p "Файл ${color_info}$target_file${color_reset} уже существует. Перезаписать его? [${color_yellow}y/n${color_reset}]: " yn
        case $yn in
            [Yy]* )
                cp "$source_file" "$target_file"
                echo "Файл ${color_info}$target_file${color_reset} перезаписан!"
                ;;
            * )
                echo "Ничего не произошло."
                ;;
        esac
    else
        cp "$source_file" "$target_file"
        echo "Файл ${color_info}$target_file${color_reset} создан из ${color_info}$source_file${color_reset}!"
    fi
}


check_required_vars() {
    local missing_vars=()
    for var_name in "$@"; do
        if [[ -z "${!var_name}" ]]; then
            log_error "Не заполнена переменная ${color_info}${var_name}${color_reset}"
            missing_vars+=("$var_name")
        fi
    done
    
    if [[ ${#missing_vars[@]} -ne 0 ]]; then
        return 1
    fi
}

