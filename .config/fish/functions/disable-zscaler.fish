function disable-zscaler
    echo "Disabling Zscaler..."

    # Unload and move LaunchDaemons/Agents to backup
    for file in /Library/LaunchDaemons/com.zscaler.* /Library/LaunchAgents/com.zscaler.*
        if test -e $file
            echo "Unloading and backing up $file"
            sudo launchctl unload $file 2>/dev/null
            sudo mv $file ~/Desktop/
            if test $status -eq 0
                echo "Successfully moved $(basename $file)"
            else
                echo "Failed to move $(basename $file)"
            end
        end
    end

    # Remove Zscaler from login items
    echo "Checking login items..."
    set login_items (osascript -e 'tell application "System Events" to get the name of every login item' 2>/dev/null)
    for item in $login_items
        if string match -qi "*zscaler*" $item
            echo "Removing login item: $item"
            osascript -e "tell application \"System Events\" to delete login item \"$item\"" 2>/dev/null
        end
    end

    # Kill Zscaler processes more specifically
    echo "Stopping Zscaler processes..."
    for proc in "Zscaler" "ZscalerTunnel" "ZscalerService"
        if pgrep -f $proc >/dev/null
            echo "Killing $proc"
            sudo pkill -f $proc
        end
    end

    echo "Zscaler disabled."
end
