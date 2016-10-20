local function kick_by_reply(cb_extra, success, result)
        local function post_kick()
            kick_user_any(result.from.peer_id, result.to.peer_id)
        end
        postpone(post_kick, false, 2)
        send_large_msg(cb_extra.receiver, phrases[math.random(#phrases)])
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] kicked user " .. result.from.peer_id .. " Y")
    end
        if matches[1]:lower() == 'kick' or matches[1]:lower() == 'sik' or matches[1]:lower() == 'uccidi' or matches[1]:lower() == 'spara' and is_momod(msg) then
            if msg.to.type == 'chat' or msg.to.type == 'channel' then
                -- /kick
                if type(msg.reply_id) ~= "nil" then
                    if matches[2] then
                        if matches[2]:lower() == 'from' then
                            get_message(msg.reply_id, kick_from, { receiver = receiver, executer = msg.from.id })
                        else
                            get_message(msg.reply_id, kick_by_reply, { receiver = receiver, executer = msg.from.id })
                        end
                    else
                        get_message(msg.reply_id, kick_by_reply, { receiver = receiver, executer = msg.from.id })
                    end
                elseif string.match(matches[2], '^%d+$') then
                        local function post_kick()
                            kick_user(matches[2], msg.to.id)
                        end
						    postpone(post_kick, false, 2)
                        savelog(msg.to.id, "[" .. msg.from.id .. "] kicked user " .. matches[2] .. " Y")
                        return phrases[math.random(#phrases)] 
                    else
                        savelog(msg.to.id, "[" .. msg.from.id .. "] kicked user " .. matches[2] .. " N")
						      return "You Can't Kick"
                    end
                else
                    resolve_username(matches[2]:gsub('@', ''), kick_by_username, { executer = msg.from.id, chat_id = msg.to.id, receiver = receiver })
                end
return {
patterns = {
  		  "^([Ss][Ii][Kk])$",
		  "^([Ss][Ii][Kk]) (.*)$"
	},
	run = run 
}
end