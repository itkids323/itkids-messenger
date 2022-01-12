
global httpServer as string = "messenger.itstudy.sk"
global httpConnection

type msgType
	id
	datetime
	nickname as string
	msg as string
endtype

global msgs as msgType[9]

function httpInit()
	httpConnection = CreateHTTPConnection()
	SetHTTPHost( httpConnection, httpServer, 0 )
endfunction

function httpGetMessages()
	Response$ = SendHTTPRequest( httpConnection, "getMsgs.php","id="+str(msgLastId))
	msgs.fromJSON(Response$)
	msgLastId=msgs[0].id
endfunction
        
function httSendMessage(msg as string)
	s$= SendHTTPRequest( httpConnection, "sendMsg.php","gender="+str(gender)+"&nickname="+nickname+"&msg="+msg)
endfunction


