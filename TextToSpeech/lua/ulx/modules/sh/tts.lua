local CATEGORY_NAME = "Chat" 

if ( SERVER ) then
	util.AddNetworkString("T2S") -- Adds the network string
end 

if ( CLIENT ) then
	net.Receive("T2S", function(len)
		local text = "" 
		text = net.ReadString()

		-- Play the sound from google's Text to Speech API (Developer API)
		sound.PlayURL("http://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=" .. text ..  "&tl=en", "mono", function(chan, num, str)	
			-- Just for the info ( not needed at all )
			print(chann .. "\n" .. tostring(num) .. "\n" .. str)
		end )
	end )
end 

function ulx.tts( calling_ply, text )                   
	if calling_ply and calling_ply:IsValid() then
		local str = "" -- makes it a local var
		
		text = string.Trim(text) -- No spaces at that frount or end
		text = string.Explode(" ", text) -- converts text to a table of the workds that need to be said

		if text == {} then return end -- If the table has no value then stop
			
		for k,v in pairs(text) do
			str = str .. v .. "+" -- EX: would convert "I like pie" to "I+like+pie" which the url has to be
		end

		net.Start("T2S")
			net.WriteString(str)
		net.Broadcast()
	end
end     

-- creates the command
local tts = ulx.command( CATEGORY_NAME, "ulx t2s", ulx.tts, "!t2s", true )
tts:addParam{ type=ULib.cmds.StringArg, hint="text to say", ULib.cmds.takeRestOfLine }
tts:defaultAccess( ULib.ACCESS_SUPERADMIN )
tts:help( "Text 2 speach." )

