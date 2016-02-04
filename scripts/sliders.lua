--[[
Copyright 2013, Crank Software Inc.
All Rights Reserved.
For more information email info@cranksoftware.com
** FOR DEMO PURPOSES ONLY **
]]--

local SLIDER_MIN = 8
local SLIDER_MAX = 108
local SLIDER_HEIGHT = 54
local MAX_TICKS = 6 

local ACTIVE_SLIDER = nil

function calc_slider_position(mapargs)
	local press_y = mapargs.context_event_data.y
	local v = {}
	control = gre.get_control_attrs(mapargs.context_control, "y")
	local new_y = press_y - control["y"] - (SLIDER_HEIGHT / 2)
	
	if new_y < SLIDER_MIN then
		new_y = SLIDER_MIN
	elseif new_y > SLIDER_MAX then
		new_y = SLIDER_MAX
	end
	
	local data = {}
	data[mapargs.context_control..".slider_offset"] = new_y
	gre.set_data(data)
	
	local num_ticks = (MAX_TICKS + 1) - math.ceil((new_y / (SLIDER_MAX - SLIDER_MIN)) * MAX_TICKS)
	v = gre.get_data(mapargs.context_control..".slider_num")
	set_equalizer(v[mapargs.context_control..".slider_num"], num_ticks)
end

function cb_slider_press(mapargs)
	ACTIVE_SLIDER = mapargs.context_control
	
	calc_slider_position(mapargs)
end


function cb_slider_motion(mapargs)
	
	if ACTIVE_SLIDER == nil then
		return
	end
	
	if ACTIVE_SLIDER == mapargs.context_control then
		calc_slider_position(mapargs)
	end
end


function cb_slider_release(mapargs)
	ACTIVE_SLIDER = nil	

end

function set_equalizer(eq_num, num)
	local data = {}
	
	local name_str = "equalizer.equalizer%d.alpha.%d.1"
	
	for i=1, 6 do
		local name = string.format(name_str, eq_num, i)
		if i >  (6 - num) then
			data[name] = 255
		else
		 	data[name] = 0
		end
	end
	gre.set_data(data)
end

function cb_equilizer_on(mapargs)
	set_equalizer(1,3)
	set_equalizer(2,3)
	set_equalizer(3,3)
	set_equalizer(4,3)
	set_equalizer(5,3)
	set_equalizer(6,3)
end

function cb_equilizer_off(mapargs)
	set_equalizer(1,0)
	set_equalizer(2,0)
	set_equalizer(3,0)
	set_equalizer(4,0)
	set_equalizer(5,0)
	set_equalizer(6,0)
end