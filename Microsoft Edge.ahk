#Requires AutoHotkey v2.0

; ^ = Ctrl, ! = Alt, + = Shift, # = Win
; left arrow = {Left}, right arrow = {Right}

isEdge() {
    return WinGetProcessName("A") == "msedge.exe"
}
; if I am in the desktop state, I want to make f1 to open the edge browser
F1:: {
    if WinGetTitle("A") == "Program Manager" {
        Run "msedge.exe"
    }
    return
}

F2:: {
    if WinGetTitle("A") == "Program Manager" {
        Run "explorer.exe"
    }
    return
}

!Right:: {
    if WinGetTitle("A") == "Task Switching" {
        Send "{Alt Down}{Right}"
    }
    if isEdge() {
        Send "{Alt Up}"
        Send "^{Tab}"
        Send "{Alt Down}"
    }
    return
}

!Left:: {
    if WinGetTitle("A") == "Task Switching" {
        Send "{Alt Down}{Left}"
    }
    if isEdge() {
        Send "{Alt Up}"
        Send "^+{Tab}"
        Send "{Alt Down}"
    }
    return
}

^E:: {
    if isEdge() {
        SendInput "^l"
        Send "{Backspace}"
    }
    return
}

; !Down:: {
;     if isEdge() {
;         SendInput "{Esc}"
;         SendInput "{Esc}"
;         SendInput "^l"
;         Sleep 50
;         SendInput "^+{Enter}"
;     }
;     return
; }

; Open a Selected Tab in a new window
!Down:: {
    process := WinGetProcessName("A")
    if isEdge() && WinGetTitle("A") != "Task Switching" {
        BlockInput(true)
        SendInput "{Esc}{Esc}{Esc}"
        old_clipboard := A_Clipboard
        SendInput("^l") ; Focus the address bar
        Sleep 100
        SendInput("^c") ; Copy the URL
        Sleep 100
        SendInput("^w") ; Close the tab
        if ClipWait() == 1 {
            Run (process) ; Open a new window
            if WinWaitActive("ahk_exe " process) {
                SendInput("^l") ; Open a new tab
                Sleep 100
                SendInput("^v{Enter}") ; Paste the URL
                Sleep 100
                A_Clipboard := old_clipboard
                BlockInput(false)
            }
        }
    } else {
        SendInput("{Alt Down}{Down}") ; Open a new tab
    }
    ; Unfreeze any activity
}
