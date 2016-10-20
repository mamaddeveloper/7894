local function history(extra, suc, result)
for i=1, #result do
delete_msg(result[i].id, ok_cb, false)
end
if tonumber(extra.con) == #result then
send_msg(extra.chatid, ''..#result..' recent msgs are removed!', ok_cb, false)
else
send_msg(extra.chatid, ' all of msgs are removed!!', ok_cb, false)
end
end
local function allhistory(extra, suc, result)
for i=1, #result do
delete_msg(result[i].id, ok_cb, false)
end
if #result == 999 then
get_history(msg.to.peer_id, 1000, allhistory , {chatid = msg.to.peer_id})
else
send_msg(extra.chatid, ' all of msgs are removed!!', ok_cb, false)
end
end
local function run(msg, matches)
if matches[1] == 'delmsg' or matches[1] == 'rmsg' then
        if msg.to.type == 'channel' then
		  if is_momod(msg) then
        if tonumber(matches[2]) > 999 or tonumber(matches[2]) < 1 then
        return "Error!!!Please choose a number 1-999!"
       end
            get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
        else
        return "only for mods or higher"
       end
end
end
		
if matches[1] == 'cleanmsgs' then
        if msg.to.type == 'channel' then
		   if is_momod(msg) then
            get_history(msg.to.peer_id, 1000, allhistory , {chatid = msg.to.peer_id})
        else
        return "only for mod or higher"
        end
end
end
end
return {
    patterns = {
        '^[!/#](delmsg) (%d*)$',
		  '^[!/#](rmsg) (%d*)$',
        '^[!/#](cleanmsgs)$',
		  '^(delmsg) (%d*)$',
		  '^(rmsg) (%d*)$',
        '^(cleanmsgs)$'
    },
    run = run
}