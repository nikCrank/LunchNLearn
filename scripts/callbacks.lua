--[[
Copyright 2013, Crank Software Inc.
All Rights Reserved.
For more information email info@cranksoftware.com
** FOR DEMO PURPOSES ONLY **
]]--

local POWER =0

function cb_toggle_power(mapargs) 
	local data = {}
	
	if POWER == 0 then
		POWER = 1
		data["VU.power.image"] = "images/power_on.png"
		gre.send_event("POWER_ON")
		gre.send_event("START_PLAYING")		
	else
		POWER = 0
		data["VU.power.image"] = "images/power_off.png"
		gre.send_event("POWER_OFF")
	end
	gre.set_data(data)
end

