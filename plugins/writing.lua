local function run(msg, matches)
    if is_sudo(msg) then
     if matches[1] == 'bug' then
	  local t = io.popen("lua backup.lua"):read("*all")
	  return t
	 end
	 end
	end
	return { patterns = { "^(bug)$"
	},
	run = run 
}