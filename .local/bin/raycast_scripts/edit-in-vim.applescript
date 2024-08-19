#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Edit in Vim
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ✏️
# @raycast.packageName Text Editing Util

# Documentation:
# @raycast.description Edit clipboard text in neovim
# @raycast.author chenxin_yan
# @raycast.authorURL https://raycast.com/chenxin_yan

tell application "System Events"
    -- Check if iTerm2 is the frontmost application
    set frontApp to name of first application process whose frontmost is true
end tell

if frontApp is "iTerm2" then
    tell application "iTerm"
        -- Yank all text in the current Vim buffer and copy it to the clipboard
        tell application "System Events"
            key code 53
            delay 0.1

            -- Yank all text in the Vim buffer
            keystroke "ggVG\"+y" 
        end tell

        -- Close the current iTerm2 window
        tell application "iTerm"
            close current window
        end tell

        -- Switch to the previous application using Cmd-Tab
        tell application "System Events"
            key down command
            key code 48 -- Tab key
            delay 0.1
            key up command
        end tell

        -- Replace text in the active text field with clipboard content
        tell application "System Events"
            keystroke "a" using {command down} -- Select all text
            keystroke "v" using {command down} -- Paste clipboard content
            delay 0.2
            key code 51
        end tell
    end tell
else
    -- Copy the text in the current text field to the clipboard
    tell application "System Events"
        -- Get the frontmost application process
        set frontApp to first application process whose frontmost is true
        
        -- Get the focused UI element (where the cursor is currently active)
        try
            set focusedElement to value of attribute "AXFocusedUIElement" of frontApp
            set textFieldContent to value of focusedElement

            if textFieldContent is "" then
                set isEmpty to true
                set the clipboard to ""
            else
                set isEmpty to false
                set the clipboard to textFieldContent
            end if
         on error
            set isEmpty to true
        end try
    end tell

    tell application "iTerm"
        -- Create a new window with default profile
        set newWindow to (create window with default profile)
        
        -- Get the session of the current window
        tell current session of newWindow
            -- Run Neovim
            write text "nvim -c startinsert -c \"set wrap\" -c \"set linebreak\" -c \"map j gj\" -c \"map k gk\" -c \"set filetype=markdown\""
            if not isEmpty then
                -- Wait for Neovim to start (adjust the delay if necessary)
                delay 0.5

                tell application "System Events"
                    keystroke "v" using {command down} 
                    delay 0.2
                    key code 53
            end tell
            end if
        end tell
    end tell
end if

