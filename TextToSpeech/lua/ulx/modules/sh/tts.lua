local CATEGORY_NAME = "Chat" 

if ( SERVER ) then
	util.AddNetworkString("T2S")
end 

if ( CLIENT ) then
	net.Receive("T2S", function(len)
		local text = ""
		text = net.ReadString()

		sound.PlayURL("http://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=" .. text .. "&tl=en", "mono", function(chan, num, str)	end )
	end )
end 

function ulx.tts( calling_ply, text )                   
	if calling_ply and calling_ply:IsValid() then
		local str = ""
		
		text = string.Trim(text)
		text = string.Explode(" ", text)

		if text == {} or text[1] == "" then return end
			
		for k,v in pairs(text) do
			str = str .. v .. "%20"
		end

		net.Start("T2S")
			net.WriteString(str)
		net.Broadcast()
	end
end     

local tts = ulx.command( CATEGORY_NAME, "ulx t2s", ulx.tts, "!t2s", true )
tts:addParam{ type=ULib.cmds.StringArg, hint="text to say", ULib.cmds.takeRestOfLine }
tts:defaultAccess( ULib.ACCESS_SUPERADMIN )
tts:help( "Text 2 speach." )

