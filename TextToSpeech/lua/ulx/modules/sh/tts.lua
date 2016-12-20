local CATEGORY_NAME = "Chat"

if ( SERVER ) then
	util.AddNetworkString("T2S") 
end

if ( CLIENT ) then
	net.Receive("T2S", function(len)
		local text = ""
		text = net.ReadString()

		sound.PlayURL("http://www.voicerss.org/controls/speech.ashx?hl=en-us&c=mp3&rnd=1&src=" .. text, "mono", function(chan, num, str)
			-- body
		end ) 
	end ) 
end 

function ulx.tts( calling_ply, text )
	if calling_ply and calling_ply:IsValid() then
		text = string.Trim( text )

		if text == "" then return end
		
		text = string.gsub( text, ' ', '+' ) 

		net.Start("T2S") 
			net.WriteString(text) 
		net.Broadcast()
	end 
end 

local tts = ulx.command( CATEGORY_NAME, "ulx t2s", ulx.tts, "!t2s", true )
tts:addParam{ type=ULib.cmds.StringArg, hint="text to say", ULib.cmds.takeRestOfLine } 
tts:defaultAccess( ULib.ACCESS_SUPERADMIN ) 
tts:help( "Text 2 speach." ) 
