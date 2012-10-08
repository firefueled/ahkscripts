^!s::
KeyWait s
KeyWait Alt
KeyWait Control

;define your escaped delimiter and separator here
delimiter = `:
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