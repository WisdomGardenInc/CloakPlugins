#!/bin/bash

# ohpm publish plugins/CloakPluginPermission/build/default/outputs/default/CloakPluginPermission.har
# ohpm publish plugins/CloakPluginHttp/build/default/outputs/default/CloakPluginHttp.har
# ohpm publish plugins/CloakPluginInAppBrowser/build/default/outputs/default/CloakPluginInAppBrowser.har

function select_modules() {
    local modules=("$@")
    local dirs=()
    
    if [[ ${#modules[@]} -gt 0 ]]; then
        # if there are parameters, use them as options
        dirs=("${modules[@]}")
    else
        # else if there are no parameters, loop through all plugin directories
        while IFS= read -r dir; do
            local har_file="$dir/build/default/outputs/default/$(basename "$dir").har"
            if [[ -f "$har_file" ]]; then
                dirs+=("$(basename "$dir")")
            fi
        done < <(find plugins -maxdepth 1 -type d -name 'CloakPlugin*')
    fi

    # check if there are available modules
    if [[ ${#dirs[@]} -eq 0 ]]; then
        echo "Error: No available modules found"
        return 1
    fi

    # show the selection menu
    echo "Available modules:"
    echo " 0) All"
    for i in "${!dirs[@]}"; do
        printf "%2d) %s\n" "$((i + 1))" "${dirs[i]}"
    done

    # read the user input
    local input
    read -p "Enter selection numbers (space/comma separated): " input

    # handle the selection
    local selected=()
    local -a nums
    IFS=',， ' read -ra nums <<<"$input"
    local exists=""
    local all_selected=false

    # check if all is selected
    for n in "${nums[@]}"; do
        if [[ $n == 0 ]]; then
            all_selected=true
            break
        fi
    done

    if $all_selected; then
        selected=("${dirs[@]}")
    else
        # handle single selection
        for n in "${nums[@]}"; do
            if [[ $n =~ ^[0-9]+$ ]]; then
                local idx=$((n - 1))
                if ((idx >= 0 && idx < ${#dirs[@]})) &&
                    [[ ! "$exists" =~ (^| )$idx($| ) ]]; then
                    selected+=("${dirs[idx]}")
                    exists+=" $idx "
                fi
            fi
        done
    fi

    # output the result to temporary file
    if [[ ${#selected[@]} -gt 0 ]]; then
        for module in "${selected[@]}"; do
            echo "$module" >> ./tmp/publish_selected_modules.txt
        done
        return 0
    else
        echo "No valid modules selected"
        return 1
    fi
}

function publish_module() {
    local module="$1"
    local har_file="plugins/${module}/build/default/outputs/default/${module}.har"
    
    if [[ -f "$har_file" ]]; then
        echo "Publishing $module"
        echo "----------------------------------------"
        local size=$(ls -lh "$har_file" | awk '{print $5}')
        local date=$(ls -lh "$har_file" | awk '{print $6, $7, $8}')
        printf "%-30s %-10s %s\n" "$module.har" "$size" "$date"
        echo "----------------------------------------"
        
        # copy to local directory
        mkdir -p local_hars
        cp "$har_file" "local_hars/"
        
        # publish
        echo "ohpm publish $har_file"
        ohpm publish "$har_file"
        echo "----------------------------------------"
    else
        echo "Error: HAR file not found for $module"
    fi
}

main() {
    # get command line parameters
    local modules=("$@")
    
    # clear temporary file
    > ./tmp/publish_selected_modules.txt
    
    # select the modules to publish
    if ! select_modules "${modules[@]}"; then
        exit 1
    fi
    
    # read selected modules from temporary file
    local selected_modules=()
    while IFS= read -r module; do
        selected_modules+=("$module")
    done < ./tmp/publish_selected_modules.txt

    if [[ ${#selected_modules[@]} -eq 0 ]]; then
        exit 1
    fi

    # publish selected modules
    for module in "${selected_modules[@]}"; do
        publish_module "$module"
    done
}

main "$@"