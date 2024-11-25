; ^ = Ctrl, ! = Alt, + = Shift, # = Win
; left arrow = {Left}, right arrow = {Right}
#Requires AutoHotkey v2.0

blacklist := ["msedge.exe", "explorer.exe", "Code.exe"]

isBlacklisted() {
    return blacklist.Has(WinGetProcessName("A"))
}

!Right:: {
    if WinGetTitle("A") == "Task Switching" {
        Send "{Alt Down}{Right}"
    }
    else if !isBlacklisted() {
        Send "{Alt Up}"
        Send "^{Tab}"
        Send "{Alt Down}"
    }
}

!Left:: {
    if WinGetTitle("A") == "Task Switching" {
        Send "{Alt Down}{Left}"
    }
    else if !isBlacklisted() {
        Send "{Alt Up}"
        Send "^+{Tab}"
        Send "{Alt Down}"
    }
}
