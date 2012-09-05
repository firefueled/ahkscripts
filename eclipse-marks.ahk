; ITERATES OVER ECLIPSE MARKS (THE COLORED DASHES ON THE LEFT SIDE THAT INDICATE WARNINGS AND ERRORS IN THE CODE)
^!l::
	x = 1330
	bar = % 700 - 130
	normalColor = 0xF0F0F0
	gap = 4
	y = 130
	marks := []
	current = 0
	
	;get all the marks
	Loop, % y
	{
		if % y >= bar
		{
			break
		}
		
		PixelGetColor color, %x%, %y%
		if % color != normalColor
		{
			marks.Insert(y)
		}
		
		y = % y + gap
	}
	MsgBox % marks.MaxIndex()
return

^PgDn::
	if % current >= marks.MaxIndex()
		current = 1
	else
		current = % current + 1
		
	y = % marks[current]
	Click %x%, %y%
return

^PgUp::
	if current <= 1
		current = % marks.MaxIndex()
	else
		current = % current - 1
		
	y = % marks[current]
	Click %x%, %y%
return