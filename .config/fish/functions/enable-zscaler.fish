function enable-zscaler
    echo "Enabling Zscaler..."

    # Restore LaunchDaemons from Desktop
    for file in (ls ~/Desktop/com.zscaler.* 2>/dev/null)
        if test -e $file
            echo "Restoring $file"
            sudo mv $file /Library/LaunchDaemons/
        end
    end

    # Start Zscaler processes
    echo "Starting Zscaler..."
    for plist in /Library/LaunchDaemons/com.zscaler.*
        if test -e $plist
            echo "Loading $plist"
            sudo launchctl load $plist
        end
    end

    echo "Zscaler enabled."
end
