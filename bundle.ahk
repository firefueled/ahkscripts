^!q::Reload 

;BUNDLER - COPIES THE CONTENTS OF ALL THE FILES UNDER THIS DIRECTORY
;YOU CAN DELETE THIS LATER
scriptDir := A_ScriptDir
scriptFile := A_ScriptName
scriptPath = %scriptDir%\%scriptFile%
script := FileOpen(scriptPath, "rw -wd")

scriptContent := script.Read()
commented := RegExReplace(scriptContent, "`n", "`n`;")
script.Seek(0)
script.Write(commented)
script.Write("`n`n`;`#`#`#`#`# COPIED FILES `#`#`#`#`#")

Loop, %scriptDir%\*.ahk {
	if (A_LoopFileName <> scriptFile) {
		file := FileOpen(A_LoopFileName, "r")
		content := file.Read()
		MsgBox % A_LoopFileName
		script.Write("`n`n`;`#`#`# ")
		script.Write(A_LoopFileName)
		script.Write("`n")
		script.Write(content)
		file.Close()
	}
}
script.Close()

Edit