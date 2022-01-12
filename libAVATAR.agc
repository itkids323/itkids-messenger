// libAVATAR (version 1.0.1)

// Usage: sprite = createSpriteAvatar(gender,background,skin,face,eyes,brow,mouth,facewear,hair,shirt)
// 
// gender - 0 male, 1 female
// background - (0 .. 10)
// skin - (0 .. 4)
// face - male (0 .. 10), female (0 .. 5)
// eyes - (0 .. 10)
// brow - (0 .. 8)
// mouth - male (0 .. 11), female (0 .. 12)
// facewear - male (0 .. 7), female (0 .. 15)
// hair - male (0 .. 16), female (0 .. 15)
// shirt - male (0 .. 17), female (0 .. 18)

global last_avatar_gender

function createSpriteAvatar(gender,background,skin,face,eyes,brow,mouth,facewear,hair,shirt)
	SetFolder("avatarLayers")
	last_avatar_gender=gender
	g$="m"
	if gender>0 then g$="f"
	if background=0
		background=LoadImage("none.png")
	else
		background=LoadImage("background"+str(background)+".png")
	endif
	skin=LoadImage("skin"+str(skin)+"_"+g$+".png")
	
	if face=0
		face=LoadImage("none.png")
	else
		face=LoadImage("face"+str(face)+"_"+g$+".png")
	endif
	if eyes=0
		eyes=LoadImage("none.png")
	else
		eyes=LoadImage("eyes"+str(eyes)+".png")
	endif
	if brow=0
		brow=LoadImage("none.png")
	else
		brow=LoadImage("brow"+str(brow)+".png")
	endif
	if mouth=0
		mouth=LoadImage("none.png")
	else
		mouth=LoadImage("mouth"+str(mouth)+"_"+g$+".png")
	endif
	if facewear=0
		facewear=LoadImage("none.png")
	else
		facewear=LoadImage("facewear"+str(facewear)+"_"+g$+".png")
	endif
	shirt=LoadImage("shirt"+str(shirt)+"_"+g$+".png")
	if hair=0
		hair=LoadImage("none.png")
	else
		hair=LoadImage("hair"+str(hair)+"_"+g$+".png")
	endif
	img=mergeImages(background,skin)
	img2=mergeImages(img,face)
	img3=mergeImages(img2,eyes)
	img4=mergeImages(img3,brow)
	img5=mergeImages(img4,mouth)
	img6=mergeImages(img5,facewear)
	img7=mergeImages(img6,shirt)
	finalimg=mergeImages(img7,hair)
	
	id=CreateSprite(finalimg)
	for i=background to img7
		DeleteImage(i)
	next
	SetFolder("..")
endfunction id

function createSpriteRandomAvatar(gender)
	//background=Random(1,10)
	background=0 // disable background
	skin=Random(0,1)
	eyes=Random(1,10)
	brow=Random(1,8)
	face=0
	facewear=0
	if gender=0
		if Random(0,5)=0 then face=Random(1,10)
		if Random(0,5)=0 then facewear=Random(1,7)
		mouth=Random(1,11)
		hair=Random(0,16)
		shirt=Random(0,17)
	else
		if Random(0,5)=0 then face=Random(1,5)
		if Random(0,5)=0 then facewear=Random(1,15)
		mouth=Random(1,12)
		hair=Random(1,15)
		shirt=Random(0,18)
	endif
	id=createSpriteAvatar(gender,background,skin,face,eyes,brow,mouth,facewear,hair,shirt)
endfunction id

function mergeImages(img1,img2)
	mem1=CreateMemblockFromImage(img1)
	mem2=CreateMemblockFromImage(img2)
	for y=0 to GetImageHeight(img1)-1
		for x=0 to GetImageWidth(img1)-1
			adr=12+y*GetImageWidth(img1)*4+x*4
			i=GetMemblockInt(mem2,adr)
			if i<>0 then SetMemblockInt(mem1,adr,i)
		next
	next
	id=CreateImageFromMemblock(mem1)
	DeleteMemblock(mem1)
	DeleteMemblock(mem2)
endfunction id
