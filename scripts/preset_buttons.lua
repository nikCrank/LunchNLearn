--[[
Copyright 2013, Crank Software Inc.
All Rights Reserved.
For more information email info@cranksoftware.com
** FOR DEMO PURPOSES ONLY **
]]--

local preset_str = "presets.preset%d"
local num_presets = 6

function cb_preset_press(mapargs)
	local data = {}
	
	for i = 1, num_presets do
		local preset_name = string.format(preset_str, i)
		if preset_name == mapargs.context_control then	
			data[preset_name..".text_colour"] = 0xFFDD000
			data[preset_name..".image"] = "images/preset_on.png"
		else
			data[preset_name..".text_colour"] = 0x252525
			data[preset_name..".image"] = "images/preset_off.png"
		end
	end
	gre.set_data(data)	
end

function cb_preset_power_on(mapargs)
	local data = {}
	
	local preset_name = string.format(preset_str, 1)
	data[preset_name..".text_colour"] = 0xFFDD000
	data[preset_name..".image"] = "images/preset_on.png"
	
	for i = 2, num_presets do
		preset_name = string.format(preset_str, i)
		data[preset_name..".text_colour"] = 0x252525
		data[preset_name..".image"] = "images/preset_off.png"
	end
	gre.set_data(data)	
end

function cb_preset_power_off(mapargs)
	local data = {}
	
	for i = 1, num_presets do
		local preset_name = string.format(preset_str, i)
		data[preset_name..".text_colour"] = 0x252525
		data[preset_name..".image"] = "images/preset_off.png"
	end
	gre.set_data(data)	
end