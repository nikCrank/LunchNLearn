--[[
Copyright 2013, Crank Software Inc.
All Rights Reserved.
For more information email info@cranksoftware.com
** FOR DEMO PURPOSES ONLY **
]]--

local g_state = "PAUSE"
local g_progress = 0
local g_timer_id = nil

function cb_play_pause(mapargs)
	local data = {}
	
	if g_state == "PAUSE" then 
		g_state = "PLAY"
		g_timer_id=gre.timer_set_interval(cb_progress_timer,50)
		data["progress_bar.play_pause.image"] = "images/play_pause_up.png"
	else
		g_state = "PAUSE"
		gre.timer_clear_timeout(g_timer_id)
		g_timer_id = nil
		data["progress_bar.play_pause.image"] = "images/play_pause_down.png"
	end
	gre.set_data(data)
end


function cb_progress_timer(mapargs)
	local data = {}
	local progress_max_width = 225
	
	g_progress = g_progress + 0.1
	data["progress_bar.progress_bar_fill.progress_width"] = math.ceil((g_progress / 100) * progress_max_width)

	-- if we are greater that 100% reset and pause
	if g_progress > 100	then
		g_state = "PAUSE"
		gre.timer_clear_timeout(g_timer_id)
		g_timer_id = nil
		data["progress_bar.play_pause.image"] = "images/play_pause_down.png"	
		data["progress_bar.progress_bar_fill.progress_width"] = 0
	end
	
	gre.set_data(data)
end

function cb_progress_power_off(mapargs)
	local data = {}
	
	g_state = "PAUSE"
	if g_timer_id ~= nil then
		gre.timer_clear_timeout(g_timer_id)
	end
	data["progress_bar.play_pause.image"] = "images/play_pause_down.png"	
	data["progress_bar.progress_bar_fill.progress_width"] = 0
	g_progress=0
	gre.set_data(data)
end

