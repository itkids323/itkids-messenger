
// Project: ITkids Messanger
// Created: 2021-12-27

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "ITkids Messenger" )

global screenWidth = 480
global screenHeight = 854

if GetDeviceBaseName()="android" or GetDeviceBaseName()="ios"
	SetImmersiveMode(1)
	for i=1 to 5
		sync()
	next
	k#=GetDeviceWidth()/480.0
	screenHeight=GetDeviceHeight()/k#	// calculate new height
endif

// set display properties
SetWindowSize( screenWidth, screenHeight, 0 )
SetVirtualResolution( screenWidth, screenHeight )
SetDefaultMagFilter(0)
SetOrientationAllowed( 1, 1, 0, 0 ) 	// allow portrait on mobile devices
SetSyncRate( 30, 0 )					// 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) 					// use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) 				// use nicer default fonts

#insert "messenger.agc"
#insert "functions.agc"
#insert "httpConnection.agc"
#insert "libAVATAR.agc"


SetClearColor(255,255,255)
SetPrintColor(0,0,0)

httpInit()
httpGetMessages()
loginScreen()
chatScreen()
