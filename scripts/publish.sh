#!/bin/bash

# ohpm publish plugins/CloakPluginPermission/build/default/outputs/default/CloakPluginPermission.har
# ohpm publish plugins/CloakPluginHttp/build/default/outputs/default/CloakPluginHttp.har
# ohpm publish plugins/CloakPluginInAppBrowser/build/default/outputs/default/CloakPluginInAppBrowser.har

for dir in plugins/*/build/default/outputs/default; do
    files=$(find "$dir" -type f -name "*.har")
    subdir=$(basename $(dirname $(dirname $(dirname $(dirname "$dir")))))
    
    selected_file=""
    for file in $files; do
        if [[ "$file" == *"$subdir.har" ]]; then
            selected_file="$file"
            break
        fi
    done

    if [[ -n "$selected_file" ]]; then
        echo "Publishing $selected_file"
        cp $selected_file local_hars/
        ohpm publish "$selected_file"
    else
        echo "No matching .har file found for $subdir"
    fi
done