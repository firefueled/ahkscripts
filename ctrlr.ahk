^!R::
Gui:
Gui Destroy
Gui, Add, Text,, Search:
Gui, Add, Edit, r1 w210 vSearch
Gui, Add, Text,, Replace:
Gui, Add, Edit, r1 w210 vReplace
Gui, Add, Button, x+-50 y+5 gReplace Default, Replace
Gui, Show, W230 H130, Ctrl+R Everywhere
return 

GuiEscape:
Gui Destroy
return

Replace:
Gui Submit
previous := % clipboard
Sleep 100
Send ^a
Sleep 100
Send ^c
newtext := RegExReplace(clipboard, Search, Replace, count)
MsgBox, 4, %count% occurrencies., %count% occurrencies. Continue?
IfMsgBox Yes
	clipboard := % newtext
	Sleep 100
	Send ^a
	Sleep 100
	Send ^v
	clipboard := % previous
IfMsgBox No
	Gosub Gui
return

PixelChange(x,y,delay) {
	Sleep % delay
	PixelGetColor ori,x,y
	Loop {
		PixelGetColor chg,x,y
		if (chg <> ori) {
			return chg
		}
	}
}
return
