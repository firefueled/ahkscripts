^!q::Reload

^!a::
KeyWait s
KeyWait Alt
KeyWait Control

gui, font, s10 Verdana
gui, add, text,, Set Delimiter and Separator

gui, font, s30 Verdana
gui, add, edit, center section xs+40 vdelimiter, `:
gui, add, edit, center ys vseparator, `,

gui, font, s10 Verdana
gui, add, Button, section Default, OK

gui, show
return

ButtonOK:
Gui, Submit

;in case the vars are empty
if delimiter is space
	delimiter = `:

if separator is space
	separator = `,

;grabs selected text
Send ^c
text := Clipboard

;needed data will be stored in this array
t := Object()

maxlen = 0 

;finding out the biggest key and storing all the data
i = 1
Loop, parse, text, %separator%, `n`r
{	

	;RTrim() preserves identation. change to Trim() to ignore it
	key := RTrim(SubStr(A_LoopField, 1, InStr(A_LoopField, delimiter) - 1))

	keylen := StrLen(key)
	val := Trim(SubStr(A_LoopField, InStr(A_LoopField, delimiter) + 1))

	IfGreater, keylen, 0
	{
		t[i] := key delimiter val delimiter keylen

		if (keylen > maxlen)
			maxlen := keylen
	}

	i++
}

;writing the result
i = 1
Loop % t.MaxIndex() 
{
	rec := t[i]
	
	StringSplit, line, rec, %delimiter%

	key := line1
	val := line2
	keylen := line3
	
	spaces := maxlen - keylen + 1

	SendInput {Raw}%key%
	SendInput {space %spaces%}%delimiter%{space}
	SendInput {Raw}%val%

	if (i < t.MaxIndex())
	{
		SendInput, %separator%`n
		SendInput +{home}
		SendInput {del}
	}

	i++
}
return