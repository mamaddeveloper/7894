do

local function pre_process(msg)
    
    local hash = 'mate:'..msg.to.id
    if redis:get(hash) and msg.fwd_from and not is_momod(msg) then
	  delete_msg(msg.id, ok_cb, false)
            return "fwd was locked"
        end
    
        return msg
    end

  


local function run(msg, matches)
    chat_id = msg.to.id
    
    if matches[1]:lower() == 'lock' and is_momod(msg) then
      
            
                    local hash = 'mate:'..msg.to.id
                    redis:set(hash, true)
                    return ""
  elseif matches[1]:lower() == 'unlock' and is_momod(msg) then
                    local hash = 'mate:'..msg.to.id
                    redis:del(hash)
                    return ""
					end
					if matches[1] == 'status' then
                    local hash = 'mate:'..msg.to.id
                    if redis:get(hash) then
                    return "fwd is locked"
					else 
					return "fwd is not locked"

end
end
end
return {
    patterns = {
        '^[/!#]([Ll]ock) fwd$',
        '^[/!#]([Ll]nlock) fwd$',
		'^[/!#]fwd (status)$',
		'^([Ll]ock) fwd$',
      '^([Ll]nlock) fwd$',
		'^fwd (status)$',
    },
    run = run,
    pre_process = pre_process
}
end
