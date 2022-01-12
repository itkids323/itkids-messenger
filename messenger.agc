
global msgWidth as integer
msgWidth = screenWidth - 100
global yMsg as integer

global nickname as string
global gender as integer
global mgsLastId as integer = 0

global firstTextId, firstSpriteId, lastTextId, lastSpriteId



function loginScreen()
	bg=LoadSprite("messengerBG.png")

	y=screenHeight/5

	SetSpriteY(bg,y-320)

	icon = awesomeIcon("f086", screenWidth/2, y-10, 100, "#ffffff")
	SetTextAlignment(icon,1)

	title = text("ITkids Messenger", screenWidth/2, y+90, 40, "#ffffff", 1)
	SetTextAlignment(title,1)

	iconMale = awesomeIcon("f183", screenWidth/2-60, y+260, 70, "#00000")
	iconFemale = awesomeIcon("f182", screenWidth/2+30, y+260, 70, "#bbbbbb")

	nickEditBox = CreateEditBox()
	SetEditBoxSize(nickEditBox, screenWidth - 180, 50)
	SetEditBoxPosition(nickEditBox, 90, y+200)
	SetEditBoxFont(nickEditBox, font)
	SetEditBoxTextSize(nickEditBox, 40)
	SetEditBoxMaxChars(nickEditBox,16)
	SetEditBoxTextColor(nickEditBox, 187, 187, 187)
	SetEditBoxText(nickEditBox,"Guest"+str(random(0,9999)))

	loginButton = CreateSprite(0)
	SetSpriteColor(loginButton, 108, 99 , 253, 255)
	SetSpriteSize(loginButton, 208, 63)
	SetSpritePositionByOffset(loginButton, screenWidth/2, y+410)
	loginText = text("Log In", screenWidth/2, y+395, 30, "#ffffff", 1)
	SetTextAlignment(loginText,1)

	focus = 0
	gender = 0
	login = 0
	repeat
		if GetEditBoxHasFocus(nickEditBox) and focus=0
			SetEditBoxTextColor(nickEditBox, 0, 0, 0)
			SetEditBoxText(nickEditBox,"")
			focus=1
		endif
		if GetPointerState()
			xp=GetPointerX()
			yp=GetPointerY()
			if GetTextHitTest(iconMale, xp, yp)
				SetTextColor(iconMale, 0, 0, 0, 255)
				SetTextColor(iconFemale, 187, 187, 187, 255)
				gender=0
			endif
			if GetTextHitTest(iconFemale, xp, yp)
				SetTextColor(iconMale, 187, 187, 187, 255)
				SetTextColor(iconFemale, 0, 0, 0, 255)
				gender=1
			endif
			if GetSpriteHitTest(loginButton,xp,yp) then login=1
		endif
		Sync()
	until login=1 or GetRawKeyPressed(13)
	nickname = GetEditBoxText(nickEditBox)
	DeleteAllText()
	DeleteAllSprites()
	DeleteEditBox(nickEditBox)
endfunction

function chatScreen()
	msg as string
	defaultMsg as string = "Write a Message ..."

	msgEditBox = CreateEditBox()
	SetEditBoxSize(msgEditBox, screenWidth - 80, 50)
	SetEditBoxPosition(msgEditBox, 10, screenHeight - 70)
	SetEditBoxFont(msgEditBox, font)
	SetEditBoxTextSize(msgEditBox, 40)
	SetEditBoxTextColor(msgEditBox, 187, 187, 187)
	SetEditBoxUseAlternateInput(msgEditBox, 0)
	SetEditBoxText(msgEditBox, defaultMsg)

	sendIcon = awesomeIcon("f1d8", screenWidth - 50, screenHeight - 60, 34, "#4da8fd")
	SetTextFont(sendIcon, fontAwesomeRegular)

	msg="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
	msg="Ahoj, ako sa mas?"

	yMsg = screenHeight - 90

	for i=0 to msgs.length
		addNewMessage(msgs[i].datetime, msgs[i].nickname, msgs[i].msg)
		dec yMsg,20
	next

	msgsUp(100)

	focus = 0
	do
		if GetEditBoxHasFocus(msgEditBox)
			if focus = 0
				focus = 1
				if GetDeviceBaseName()="android" or GetDeviceBaseName()="ios" then SetViewOffset(0,screenHeight/2)
				SetEditBoxTextColor(msgEditBox, 0, 0, 0)
				SetEditBoxText(msgEditBox,"")
			endif
		else
			focus=0
			if GetDeviceBaseName()="android" or GetDeviceBaseName()="ios" then SetViewOffset(0,0)
			SetEditBoxTextColor(msgEditBox, 187, 187, 187)
			SetEditBoxText(msgEditBox, defaultMsg)
		endif

		if focus=1
			if GetRawKeyPressed(13)
				httSendMessage(GetEditBoxText(msgEditBox))
				SetEditBoxFocus(msgEditBox,0)
			endif
		endif
		Sync()
	loop
endfunction

function strWithZero(value)
	s as string
	s = str(value)
	if len(s)=1 then s = "0" + s
endfunction s

function addNewMessage(unixtime, nickname as string, msg as string)
	datetime as String
	datetime = strWithZero(GetDaysFromUnix(unixtime)) + "-" + strWithZero(GetMonthFromUnix(unixtime)) + "-" + strWithZero(GetYearFromUnix(unixtime)) + " " + strWithZero(GetHoursFromUnix(unixtime)) + ":" + strWithZero(GetMinutesFromUnix(unixtime))

	if 1=2
		xMsg = 10
		xAvatar = screenWidth - 44
		c = 200
	else
		xMsg = screenWidth - msgWidth - 10
		xAvatar = 44
		c = 170
	endif

	msgId = text(msg, 80,0, 18, "#000000", 0)
	if firstTextId = 0 then firstTextId = msgId
	SetTextMaxWidth(msgId, msgWidth-20)
	msgHeight = GetTextTotalHeight(msgId)+40
	if msgHeight<100 then msgHeight = 100
	dec yMsg, msgHeight

	msgBox = CreateSprite(0)
	if firstSpriteId = 0 then firstSpriteId = msgBox
	SetSpriteSize(msgBox, msgWidth, msgHeight)
	SetSpriteColor(msgBox, c, c, 253, 255)
	SetSpritePosition(msgBox, xMsg, yMsg)
	SetTextPosition(msgId, xMsg + 10, yMsg+30)

	msgId = text(nickname+" "+datetime, 80,0, 16, "#555555", 0)
	SetTextPosition(msgId, xMsg+10, yMsg+10)

	avatarCircle = LoadSprite("avatarCircle.png")
	SetSpritePositionByOffset(avatarCircle, xAvatar, yMsg+msgHeight/2)

	randomSeed = 1
	for i=1 to len(nickname)
		inc randomSeed, asc(mid(nickname,i,1))
	next
	SetRandomSeed(randomSeed)

	avatar = createSpriteRandomAvatar(0)
	SetSpriteScale(avatar, 3, 3)
	SetSpritePositionByOffset(avatar, xAvatar, yMsg+msgHeight/2-4)
	lastTextId = msgId
	lastSpriteId = avatar
endfunction

function msgsUp(offset)
	for txtId=firstTextId to lastTextId
		SetTextY(txtId, GetTextY(txtId) - offset)
	next
	for sprId=firstSpriteId to lastSpriteId
		SetSpriteY(sprId, GetSpriteY(sprId) - offset)
	next
endfunction
