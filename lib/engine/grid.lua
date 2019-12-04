-- Meadowphysics grid ops

local g = grid.connect()
local grid = {}

local rule_icons = {
  {0,0,0,0,0,0,0,0},-- o
  {0,24,24,126,126,24,24,0}, -- +
  {0,0,0,126,126,0,0,0}, -- -
  {0,96,96,126,126,96,96,0}, -- >
  {0,6,6,126,126,6,6,0}, -- <
  {0,102,102,24,24,102,102,0}, -- * rnd
  {0,120,120,102,102,30,30,0}, -- <> up/down
  {0,126,126,102,102,126,126,0} -- [] sync2 = 12
}

function grid:draw(mp)
  g:all(0)

  if(mp.grid_mode == "voice") then
  	for i = 1, #mp.voices do
	  	g:led(1, i,  1)
	  	g:led(3, i,  1)
	  	g:led(4, i,  1)
	  	g:led(6, i,  1)
	  	g:led(7, i,  1)

  		local voice = mp.voices[i]
  		if (voice.is_playing) then
  			g:led(3, i,  4)
  		end

  		if (mp.voices[mp.grid_target_focus].target_voices[i] ~= nil) then
  			g:led(4, i,  4)
  		end

  		if (voice.bang_type == "trigger") then
  			g:led(6, i,  4)
  		end

  		if (voice.bang_type == "gate") then
  			g:led(7, i,  4)
  		end

  		g:led(8 + voice.ticks_per_step, i,  4)

  	end
  end

  if (mp.grid_mode == "pattern") then
	  -- Draw position of voices
	  for i = 1, #mp.voices do
	    local voice = mp.voices[i]
	    g:led(voice.current_step, i,  4)
	  end
	end


  g:refresh()
end

return grid