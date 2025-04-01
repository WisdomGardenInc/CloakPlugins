#!/bin/bash

function select_modules() {
    # Validate plugins directory
    if [[ ! -d "plugins" ]]; then
        echo "Error: plugins directory not found"
        return 1
    fi

    # Get directory list
    local dirs=()
    local find_command="find plugins -maxdepth 1 -type d -name 'CloakPlugin*' | sort"
    while IFS= read -r dir; do
        dirs+=("$(basename "$dir")")
    done < <(eval "$find_command")

    # Check if any directories found
    if [[ ${#dirs[@]} -eq 0 ]]; then
        echo "Error: No CloakPlugin* directories found"
        return 1
    fi

    # Display selection menu
    echo "Available directories:"
    echo " 0) All"
    for i in "${!dirs[@]}"; do
        printf "%2d) %s\n" "$((i + 1))" "${dirs[i]}"
    done

    # Read user input
    local input
    read -p "Enter selection numbers (space/comma separated): " input

    # Process selection
    local selected=()
    local -a nums
    IFS=',， ' read -ra nums <<<"$input"
    local exists=""
    local all_selected=false

    # Check for '0' input
    for n in "${nums[@]}"; do
        if [[ $n == 0 ]]; then
            all_selected=true
            break
        fi
    done

    if $all_selected; then
        selected=("${dirs[@]}")
    else
        # Process individual selections
        for n in "${nums[@]}"; do
            if [[ $n =~ ^[0-9]+$ ]]; then
                local idx=$((n - 1))
                # Validate index range and duplicates
                if ((idx >= 0 && idx < ${#dirs[@]})) &&
                    [[ ! "$exists" =~ (^| )$idx($| ) ]]; then
                    selected+=("${dirs[idx]}")
                    exists+=" $idx "
                fi
            fi
        done
    fi

    # Output results
    if [[ ${#selected[@]} -gt 0 ]]; then
        # write the selected modules to the temp file
        for module in "${selected[@]}"; do
            echo "$module" >>./tmp/build_script_selected_modules.txt
        done
        return 0
    else
        echo "No valid directories selected"
        return 1
    fi
}

function init_context() {
    HARMONYOS_PROJECT_DIR=$(dirname $(dirname "$0"))
    HARMONYOS_PROJECT_DIR=$(cd "$HARMONYOS_PROJECT_DIR" && pwd)

    ohpm install --all --registry https://ohpm.openharmony.cn/ohpm/ --strict_ssl true
    hvigorw clean --no-daemon
}

function init_JDK() {
    OLD_JAVA_HOME=$JAVA_HOME
    OLD_PATH=$PATH

    export JAVA_HOME=$JAVA_HOME_17
    export PATH=$JAVA_HOME/bin:$PATH
}

function restore_JDK() {
    export JAVA_HOME=$OLD_JAVA_HOME
    export PATH=$OLD_PATH
    # echo "Restored to original JAVA_HOME: $JAVA_HOME"
}

function build_har() {
    local modules=("$@")
    local module_list=$(
        IFS=,
        echo "${modules[*]}"
    )

    echo "Building HAR for modules: ${module_list}"
    local cmd="hvigorw assembleHar --mode module -p product=default -p module=${module_list}@default -p buildMode=release -p debuggable=false --analyze=normal --parallel --incremental --no-daemon"

    echo "Executing command:"
    echo "$cmd"
    eval "$cmd"

    echo -e "\nBuild Results:"
    echo "----------------------------------------"
    for module in "${modules[@]}"; do
        local har_file="plugins/${module}/build/default/outputs/default/${module}.har"
        if [[ -f "$har_file" ]]; then
            local size=$(ls -lh "$har_file" | awk '{print $5}')
            local date=$(ls -lh "$har_file" | awk '{print $6, $7, $8}')
            printf "%-30s %-10s %s\n" "$module.har" "$size" "$date"
        fi
    done
    echo "----------------------------------------"
}

main() {
    init_context

    # clear the temp file
    mkdir -p ./tmp
    >./tmp/build_script_selected_modules.txt

    # call select_modules and check the return value
    if ! select_modules; then
        exit 1
    fi

    # read the selected modules from the temp file
    selected_modules=()
    while IFS= read -r module; do
        selected_modules+=("$module")
    done <./tmp/build_script_selected_modules.txt

    if [[ ${#selected_modules[@]} -eq 0 ]]; then
        exit 1
    fi

    local startTime=$(date '+%s')

    init_JDK
    build_har "${selected_modules[@]}"
    restore_JDK

    local endTime=$(date '+%s')
    local elapsedTime=$(expr $endTime - $startTime)
    printf "\nbuild success in ${elapsedTime}s..."
}

main
