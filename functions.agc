
global font, fontBold, fontAwesomeSolid, fontAwesomeRegular
font=LoadFont("Ubuntu-Regular.ttf")
fontBold=LoadFont("Ubuntu-Bold.ttf")
fontAwesomeSolid=LoadFont("fa-solid-900.ttf")
fontAwesomeRegular=LoadFont("fa-regular-400.ttf")

function setTextColorCode(text, color as string)
	if mid(color,1,1)="#" then color=mid(color,2,len(color)-1)
	r=val(mid(color,1,2),16)
	g=val(mid(color,3,2),16)
	b=val(mid(color,5,2),16)
	SetTextColor(text, r, g, b, 255)
endfunction

function awesomeIcon(iconHex as string, x, y, size, color as string)
	icon = CreateText(chr(val(iconHex, 16)))
	SetTextFont(icon, fontAwesomeSolid)
	SetTextPosition(icon, x, y)
	SetTextSize(icon, size)
	setTextColorCode(icon, color)
endfunction icon

function text(text as string, x, y, size, color as string, bold)
	txt = CreateText(text)
	SetTextPosition(txt, x, y)
	SetTextSize(txt, size)
	setTextColorCode(txt, color)
	if bold=0
		SetTextFont(txt, font)
	else
		SetTextFont(txt, fontBold)
	endif
endfunction txt

function strWithZero(value)
	s as string
	s = str(value)
	if len(s)=1 then s = "0" + s
endfunction s
