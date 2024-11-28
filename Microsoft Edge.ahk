#Requires AutoHotkey v2.0

; ^ = Ctrl, ! = Alt, + = Shift, # = Win
; left arrow = {Left}, right arrow = {Right}

isEdge() {
    return WinGetProcessName("A") == "msedge.exe"
}
; if I am in the desktop state, I want to make f1 to open the edge browser
F1:: {
    if WinGetTitle("A") == "Program Manager" {
        Run("msedge.exe")
    }
    return
}

F2:: {
    if WinGetTitle("A") == "Program Manager" {
        Run("explorer.exe")
    }
    return
}

!Right:: {
    if WinGetTitle("A") == "Task Switching" {
        Send ("{Alt Down}{Right}")
    }
    if isEdge() {
        Send ("{Alt Up}")
        Send ("^{Tab}")
        Send ("{Alt Down}")
    }
    return
}

!Left:: {
    if WinGetTitle("A") == "Task Switching" {
        Send ("{Alt Down}{Left}")
    }
    if isEdge() {
        Send ("{Alt Up}")
        Send ("^+{Tab}")
        Send ("{Alt Down}")
    }
    return
}

^E:: {
    if isEdge() {
        Send("^l")
        Send("{Backspace}")
    }
    return
}

; Open a Selected Tab in a new window
!Down:: {
    if isEdge() && WinGetTitle("A") != "Task Switching" {
        BlockInput(true)
        old_clipboard := A_Clipboard
        A_Clipboard := "" ; Empty the clipboard
        Send("^l") ; Focus the address bar
        loop 10 {
            Send("^c") ; Copy the URL
            if ClipWait() == 1 {
                Send("^w") ; Close the tab
                Run ("msedge.exe") ; Open a new window
                if WinWaitActive("ahk_exe  msedge.exe") {
                    Send("^l") ; Open a new tab
                    Send("^v{Enter}") ; Paste the URL
                    Sleep 1000 ; Wait for the page to load
                    A_Clipboard := old_clipboard ; Restore the clipboard
                    BlockInput(false) ; Unfreeze any activity
                }
                break
            }
        }
    } else {
        Send("{Alt Down}{Down}") ; Open a new tab
    }
}
