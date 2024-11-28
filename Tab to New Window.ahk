#Requires AutoHotkey v2.0

; ^ = Ctrl, ! = Alt, + = Shift, # = Win
; left arrow = {Left}, right arrow = {Right}

blacklist := ["msedge.exe", "explorer.exe"]

!Down:: {
    ; Freeze any activity
    BlockInput(true)

    process := WinGetProcessName("A")
    if !blacklist.Has(process) && WinGetTitle("A") != "Task Switching" {
        A_Clipboard := "" ; Empty the clipboard
        SendInput("^l") ; Focus the address bar
        Sleep 50
        SendInput("^c") ; Copy the URL
        Sleep 50
        SendInput("^w") ; Close the tab
        if ClipWait() == 1 {
            Run (process) ; Open a new window
            if WinWaitActive("ahk_exe " process) {
                SendInput("^l") ; Open a new tab
                Sleep 50
                SendInput("^v{Enter}") ; Paste the URL
            }
        }
    } else {
        SendInput("{Alt Down}{Down}") ; Open a new tab
    }
    ; Unfreeze any activity
    BlockInput(false)
}
