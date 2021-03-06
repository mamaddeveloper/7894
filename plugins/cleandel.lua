-- kick sentences
local phrases = {
    "Kicked!",
	"Ekhraj Shod",
	"Sik Shod!",
	"Az Gorouh Sik Shod",
}

local function kick_by_username(cb_extra, success, result)
    if success == 0 then
        return send_large_msg(cb_extra.receiver, lang_text('noUsernameFound'))
    end
    -- ignore higher or same rank
    if compare_ranks(cb_extra.executer, result.peer_id, cb_extra.chat_id) then
        local function post_kick()
            kick_user_any(result.peer_id, cb_extra.chat_id)
        end
        postpone(post_kick, false, 3)
        send_large_msg(cb_extra.receiver, phrases[math.random(#phrases)])
        savelog(cb_extra.chat_id, "[" .. cb_extra.executer .. "] kicked user " .. result.peer_id .. " Y")
    else
        send_large_msg(cb_extra.receiver, lang_text('require_rank'))
        savelog(cb_extra.chat_id, "[" .. cb_extra.executer .. "] kicked user " .. result.peer_id .. " N")
    end
end

local function kick_by_reply(cb_extra, success, result)
    -- ignore higher or same rank
    if compare_ranks(cb_extra.executer, result.from.peer_id, result.to.peer_id) then
        local function post_kick()
            kick_user_any(result.from.peer_id, result.to.peer_id)
        end
        postpone(post_kick, false, 3)
        send_large_msg(cb_extra.receiver, phrases[math.random(#phrases)])
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] kicked user " .. result.from.peer_id .. " Y")
    else
        send_large_msg(cb_extra.receiver, lang_text('require_rank'))
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] kicked user " .. result.from.peer_id .. " N")
    end
end

local function ban_by_username(cb_extra, success, result)
    if success == 0 then
        return send_large_msg(cb_extra.receiver, lang_text('noUsernameFound'))
    end
    -- ignore higher or same rank
    if compare_ranks(cb_extra.executer, result.peer_id, cb_extra.chat_id) then
        local function post_kick()
            ban_user(result.peer_id, cb_extra.chat_id)
        end
        postpone(post_kick, false, 3)
        send_large_msg(cb_extra.receiver, lang_text('user') .. result.peer_id .. lang_text('banned') .. '\n' .. phrases[math.random(#phrases)])
        savelog(cb_extra.chat_id, "[" .. cb_extra.executer .. "] banned user " .. result.peer_id .. " Y")
    else
        send_large_msg(cb_extra.receiver, lang_text('require_rank'))
        savelog(cb_extra.chat_id, "[" .. cb_extra.executer .. "] banned user " .. result.peer_id .. " N")
    end
end

local function ban_by_reply(cb_extra, success, result)
    -- ignore higher or same rank
    if compare_ranks(cb_extra.executer, result.from.peer_id, result.to.peer_id) then
        local function post_kick()
            ban_user(result.from.peer_id, result.to.peer_id)
        end
        postpone(post_kick, false, 3)
        send_large_msg(cb_extra.receiver, lang_text('user') .. result.from.peer_id .. lang_text('banned') .. '\n' .. phrases[math.random(#phrases)])
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] banned user " .. result.from.peer_id .. " Y")
    else
        send_large_msg(cb_extra.receiver, lang_text('require_rank'))
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] banned user " .. result.from.peer_id .. " N")
    end
end

local function unban_by_username(cb_extra, success, result)
    if success == 0 then
        return send_large_msg(cb_extra.receiver, lang_text('noUsernameFound'))
    end
    -- ignore higher or same rank
    if compare_ranks(cb_extra.executer, result.peer_id, cb_extra.chat_id) then
        local hash = 'banned:' .. cb_extra.chat_id
        redis:srem(hash, result.peer_id)
        send_large_msg(cb_extra.receiver, lang_text('user') .. result.peer_id .. lang_text('unbanned'))
        savelog(cb_extra.chat_id, "[" .. cb_extra.executer .. "] unbanned user " .. result.peer_id .. " Y")
    else
        send_large_msg(cb_extra.receiver, lang_text('require_rank'))
        savelog(cb_extra.chat_id, "[" .. cb_extra.executer .. "] unbanned user " .. result.peer_id .. " N")
    end
end

local function unban_by_reply(cb_extra, success, result)
    -- ignore higher or same rank
    if compare_ranks(cb_extra.executer, result.from.peer_id, result.to.peer_id) then
        local hash = 'banned:' .. result.to.peer_id
        redis:srem(hash, result.from.peer_id)
        send_large_msg(cb_extra.receiver, lang_text('user') .. result.from.peer_id .. lang_text('unbanned'))
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] unbanned user " .. result.from.peer_id .. " Y")
    else
        send_large_msg(cb_extra.receiver, lang_text('require_rank'))
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] unbanned user " .. result.from.peer_id .. " N")
    end
end

local function banall_by_username(cb_extra, success, result)
    if success == 0 then
        return send_large_msg(cb_extra.receiver, lang_text('noUsernameFound'))
    end
    -- ignore higher or same rank
    if compare_ranks(cb_extra.executer, result.peer_id, cb_extra.chat_id) then
        banall_user(result.peer_id)
        send_large_msg(cb_extra.receiver, lang_text('user') .. result.peer_id .. lang_text('gbanned'))
        savelog(cb_extra.chat_id, "[" .. cb_extra.executer .. "] globally banned user " .. result.peer_id .. " Y")
    else
        send_large_msg(cb_extra.receiver, lang_text('require_rank'))
        savelog(cb_extra.chat_id, "[" .. cb_extra.executer .. "] globally banned user " .. result.peer_id .. " N")
    end
end

local function banall_by_reply(cb_extra, success, result)
    -- ignore higher or same rank
    if compare_ranks(cb_extra.executer, result.from.peer_id, result.to.peer_id) then
        local function post_kick()
            banall_user(result.from.peer_id)
        end
        postpone(post_kick, false, 3)
        send_large_msg(cb_extra.receiver, lang_text('user') .. result.peer_id .. lang_text('gbanned'))
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] globally banned user " .. result.from.peer_id .. " Y")
    else
        send_large_msg(cb_extra.receiver, lang_text('require_rank'))
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] globally banned user " .. result.from.peer_id .. " N")
    end
end


local function unbanall_by_username(cb_extra, success, result)
    if success == 0 then
        return send_large_msg(cb_extra.receiver, lang_text('noUsernameFound'))
    end
    -- ignore higher or same rank
    if compare_ranks(cb_extra.executer, result.peer_id, cb_extra.chat_id) then
        unbanall_user(result.peer_id)
        send_large_msg(cb_extra.receiver, lang_text('user') .. result.peer_id .. lang_text('ungbanned'))
        savelog(cb_extra.chat_id, "[" .. cb_extra.executer .. "] globally unbanned user " .. result.peer_id .. " Y")
    else
        send_large_msg(cb_extra.receiver, lang_text('require_rank'))
        savelog(cb_extra.chat_id, "[" .. cb_extra.executer .. "] globally unbanned user " .. result.peer_id .. " N")
    end
end

local function unbanall_by_reply(cb_extra, success, result)
    -- ignore higher or same rank
    if compare_ranks(cb_extra.executer, result.from.peer_id, result.to.peer_id) then
        unbanall_user(result.from.peer_id)
        send_large_msg(cb_extra.receiver, lang_text('user') .. result.from.peer_id .. lang_text('ungbanned'))
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] globally unbanned user " .. result.from.peer_id .. " Y")
    else
        send_large_msg(cb_extra.receiver, lang_text('require_rank'))
        savelog(result.to.peer_id, "[" .. cb_extra.executer .. "] globally unbanned user " .. result.from.peer_id .. " N")
    end
end

local function kickrandom_chat(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    local kickable = false
    local id
    while not kickable do
        id = result.members[math.random(#result.members)].id
        print(id)
        if not(tonumber(id) == tonumber(our_id) or is_momod2(id, chat_id) or is_whitelisted(id)) then
            kickable = true
            send_large_msg('chat#id' .. chat_id, 'â„¹ï¸ ' .. id .. ' ' .. lang_text('kicked'))
            local function post_kick()
                kick_user_any(id, chat_id)
            end
            postpone(post_kick, false, 1)
        else
            print('403')
        end
    end
end

local function kickrandom_channel(cb_extra, success, result)
    local chat_id = msg.to.id
    local kickable = false
    local id
    while not kickable do
        id = result[math.random(#result)].id
        print(id)
        if not(tonumber(id) == tonumber(our_id) or is_momod2(id, chat_id) or is_whitelisted(id)) then
            kickable = true
            send_large_msg('channel#id' .. result.id, 'Kicked!')
            local function post_kick()
                kick_user_any(id, result.id)
            end
            postpone(post_kick, false, 1)
        else
            print('403')
        end
    end
end

local function kick_nouser_chat(cb_extra, success, result)
    for k, v in pairs(result.members) do
        if not v.username then
            kick_user(v.id, result.id)
        end
    end
end

local function kick_nouser_channel(cb_extra, success, result)
    for k, v in pairs(result) do
        if not v.username then
            kick_user(v.peer_id, cb_extra.chat_id)
        end
    end
end

local function kick_deleted_chat(cb_extra, success, result)
    for k, v in pairs(result.members) do
        if not v.print_name then
            kick_user(v.id, result.id)
        end
    end
end

local function kick_deleted_channel(cb_extra, success, result)
    for k, v in pairs(result) do
        if not v.print_name then
            kick_user(v.id, cb_extra.chat_id)
        end
    end
end

local function user_msgs(user_id, chat_id)
    local user_info
    local uhash = 'user:' .. user_id
    local user = redis:hgetall(uhash)
    local um_hash = 'msgs:' .. user_id .. ':' .. chat_id
    user_info = tonumber(redis:get(um_hash) or 0)
    return user_info
end

local function kick_inactive_chat(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    local num = cb_extra.num
    local receiver = cb_extra.receiver
    local kicked = 0

    for k, v in pairs(result.members) do
        if tonumber(v.peer_id) ~= tonumber(our_id) and not is_momod2(v.peer_id, chat_id) then
            local user_info = user_msgs(v.peer_id, chat_id)
            if tonumber(user_info) < tonumber(num) then
                if kicked == 20 then
                    break
                end
                kick_user(v.peer_id, chat_id)
                kicked = kicked + 1
            end
        end
    end
    send_large_msg(receiver, lang_text('massacre'):gsub('X', kicked))
end

local function kick_inactive_channel(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    local num = cb_extra.num
    local receiver = cb_extra.receiver
    local kicked = 0

    for k, v in pairs(result) do
        if tonumber(v.peer_id) ~= tonumber(our_id) and not is_momod2(v.peer_id, chat_id) then
            local user_info = user_msgs(v.peer_id, chat_id)
            if tonumber(user_info) < tonumber(num) then
                if kicked == 20 then
                    break
                end
                kick_user(v.peer_id, chat_id)
                kicked = kicked + 1
            end
        end
    end
    send_large_msg(receiver, lang_text('massacre'):gsub('X', kicked))
end

local function run(msg, matches)
    if msg.action and msg.action.type then
        return
    end
    local receiver = get_receiver(msg)
    if matches[1]:lower() == 'kickme' or matches[1]:lower() == 'sasha uccidimi' then
        -- /kickme
        if msg.to.type == 'chat' or msg.to.type == 'channel' then
            local print_name = user_print_name(msg.from):gsub("â€®", "")
            local name = print_name:gsub("_", "")
            savelog(msg.to.id, name .. " [" .. msg.from.id .. "] left using kickme ")
            -- Save to logs
            local function post_kick()
                kick_user_any(msg.from.id, msg.to.id)
            end
            postpone(post_kick, false, 3)
            return phrases[math.random(#phrases)]
        else
            return lang_text('useYourGroups')
        end
    end
    if is_momod(msg) then
        if matches[1]:lower() == 'kick' or matches[1]:lower() == 'sik' or matches[1]:lower() == 'sasha uccidi' or matches[1]:lower() == 'uccidi' or matches[1]:lower() == 'spara' then
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
                    -- ignore higher or same rank
                    if compare_ranks(msg.from.id, matches[2], msg.to.id) then
                        local function post_kick()
                            kick_user(matches[2], msg.to.id)
                        end
                        postpone(post_kick, false, 3)
                        savelog(msg.to.id, "[" .. msg.from.id .. "] kicked user " .. matches[2] .. " Y")
                        return phrases[math.random(#phrases)]
                    else
                        savelog(msg.to.id, "[" .. msg.from.id .. "] kicked user " .. matches[2] .. " N")
                        return lang_text('require_rank')
                    end
                else
                    resolve_username(matches[2]:gsub('@', ''), kick_by_username, { executer = msg.from.id, chat_id = msg.to.id, receiver = receiver })
                end
                return
            else
                return lang_text('useYourGroups')
            end
        end
        if matches[1]:lower() == 'kickrandom' or matches[1]:lower() == 'sasha uccidi random' or matches[1]:lower() == 'spara random' then
            if msg.to.type == 'chat' then
                chat_info(receiver, kickrandom_chat, { chat_id = msg.to.id })
            elseif msg.to.type == 'channel' then
                channel_get_users(receiver, kickrandom_channel, { chat_id = msg.to.id })
            end
            return
        end
        if matches[1]:lower() == 'ban' or matches[1]:lower() == 'sasha banna' or matches[1]:lower() == 'sasha decompila' or matches[1]:lower() == 'banna' or matches[1]:lower() == 'decompila' or matches[1]:lower() == 'esplodi' or matches[1]:lower() == 'kaboom' then
            if msg.to.type == 'chat' or msg.to.type == 'channel' then
                -- /ban
                if type(msg.reply_id) ~= "nil" then
                    if matches[2] then
                        if matches[2]:lower() == 'from' then
                            get_message(msg.reply_id, ban_from, { receiver = receiver, executer = msg.from.id })
                        else
                            get_message(msg.reply_id, ban_by_reply, { receiver = receiver, executer = msg.from.id })
                        end
                    else
                        get_message(msg.reply_id, ban_by_reply, { receiver = receiver, executer = msg.from.id })
                    end
                elseif string.match(matches[2], '^%d+$') then
                    -- ignore higher or same rank
                    if compare_ranks(msg.from.id, matches[2], msg.to.id) then
                        local function post_kick()
                            ban_user(matches[2], msg.to.id)
                        end
                        postpone(post_kick, false, 3)
                        savelog(msg.to.id, "[" .. msg.from.id .. "] banned user " .. matches[2] .. " Y")
                        return lang_text('user') .. matches[2] .. lang_text('banned') .. '\n' .. phrases[math.random(#phrases)]
                    else
                        savelog(msg.to.id, "[" .. msg.from.id .. "] banned user " .. matches[2] .. " N")
                        return lang_text('require_rank')
                    end
                else
                    resolve_username(matches[2]:gsub('@', ''), ban_by_username, { executer = msg.from.id, chat_id = msg.to.id, receiver = receiver })
                end
                return
            else
                return lang_text('useYourGroups')
            end
        end
        if matches[1]:lower() == 'unban' or matches[1]:lower() == 'sasha sbanna' or matches[1]:lower() == 'sasha ricompila' or matches[1]:lower() == 'sasha compila' or matches[1]:lower() == 'sbanna' or matches[1]:lower() == 'ricompila' or matches[1]:lower() == 'compila' then
            if msg.to.type == 'chat' or msg.to.type == 'channel' then
                -- /unban
                if type(msg.reply_id) ~= "nil" then
                    if matches[2] then
                        if matches[2]:lower() == 'from' then
                            get_message(msg.reply_id, unban_from, { receiver = receiver, executer = msg.from.id })
                        else
                            get_message(msg.reply_id, unban_by_reply, { receiver = receiver, executer = msg.from.id })
                        end
                    else
                        get_message(msg.reply_id, unban_by_reply, { receiver = receiver, executer = msg.from.id })
                    end
                elseif string.match(matches[2], '^%d+$') then
                    -- ignore higher or same rank
                    if compare_ranks(msg.from.id, matches[2], msg.to.id) then
                        local hash = 'banned:' .. msg.to.id
                        redis:srem(hash, matches[2])
                        savelog(msg.to.id, "[" .. msg.from.id .. "] unbanned user " .. matches[2] .. " Y")
                        return lang_text('user') .. matches[2] .. lang_text('unbanned')
                    else
                        savelog(msg.to.id, "[" .. msg.from.id .. "] unbanned user " .. matches[2] .. " N")
                        return lang_text('require_rank')
                    end
                else
                    resolve_username(matches[2]:gsub('@', ''), unban_by_username, { executer = msg.from.id, chat_id = msg.to.id, receiver = receiver })
                end
                return
            else
                return lang_text('useYourGroups')
            end
        end
        if matches[1]:lower() == "banlist" or matches[1]:lower() == "sasha lista ban" or matches[1]:lower() == "lista ban" then
            -- /banlist
            if matches[2] and is_admin1(msg) then
                return ban_list(matches[2])
            else
                if msg.to.type == 'chat' or msg.to.type == 'channel' then
                    return ban_list(msg.to.id)
                else
                    return lang_text('useYourGroups')
                end
            end
        end
        if matches[1]:lower() == 'clean deleted' or matches[1]:lower() == 'sasha uccidi eliminati' or matches[1]:lower() == 'spara eliminati' then
            -- /kickdeleted
            if msg.to.type == 'chat' then
                chat_info(receiver, kick_deleted_chat, { receiver = get_receiver(msg) })
            elseif msg.to.type == 'channel' then
                channel_get_users(receiver, kick_deleted_channel, { receiver = get_receiver(msg), chat_id = msg.to.id })
            end
            return
        end
        if is_owner(msg) then
            if matches[1]:lower() == 'kickinactive' or((matches[1]:lower() == 'sasha uccidi sotto' or matches[1]:lower() == 'spara sotto') and matches[3]:lower() == 'messaggi') then
                -- /kickinactive
                local num = 1
                if matches[2] then
                    num = matches[2]
                end
                if msg.to.type == 'chat' then
                    chat_info(receiver, kick_inactive_chat, { chat_id = msg.to.id, num = num, receiver = get_receiver(msg) })
                elseif msg.to.type == 'channel' then
                    channel_get_users(receiver, kick_inactive_channel, { chat_id = msg.to.id, num = num, receiver = get_receiver(msg) })
                end
                return
            end
            if matches[1]:lower() == 'kicknouser' or matches[1]:lower() == 'sasha uccidi nouser' or matches[1]:lower() == 'spara nouser' then
                -- /kicknouser
                if msg.to.type == 'chat' then
                    chat_info(receiver, kick_nouser_chat, { receiver = get_receiver(msg) })
                elseif msg.to.type == 'channel' then
                    channel_get_users(receiver, kick_nouser_channel, { receiver = get_receiver(msg), chat_id = msg.to.id })
                end
                return
            end
            if is_admin1(msg) or is_support(msg.from.id) then
                if matches[1]:lower() == 'gban' or matches[1]:lower() == 'sasha superbanna' or matches[1]:lower() == 'superbanna' then
                    -- /gban
                    if type(msg.reply_id) ~= "nil" then
                        if matches[2] then
                            if matches[2]:lower() == 'from' then
                                get_message(msg.reply_id, banall_from, { receiver = receiver, executer = msg.from.id })
                            else
                                get_message(msg.reply_id, banall_by_reply, { receiver = receiver, executer = msg.from.id })
                            end
                        else
                            get_message(msg.reply_id, banall_by_reply, { receiver = receiver, executer = msg.from.id })
                        end
                        return
                    elseif string.match(matches[2], '^%d+$') then
                        -- ignore higher or same rank
                        if compare_ranks(msg.from.id, matches[2], msg.to.id) then
                            banall_user(matches[2])
                            savelog(msg.to.id, "[" .. msg.from.id .. "] globally banned user " .. matches[2] .. " Y")
                            return lang_text('user') .. matches[2] .. lang_text('gbanned')
                        else
                            savelog(msg.to.id, "[" .. msg.from.id .. "] globally banned user " .. matches[2] .. " N")
                            return lang_text('require_rank')
                        end
                    else
                        resolve_username(matches[2]:gsub('@', ''), banall_by_username, { executer = msg.from.id, chat_id = msg.to.id, receiver = receiver })
                    end
                    return
                end
                if matches[1]:lower() == 'ungban' or matches[1]:lower() == 'sasha supersbanna' or matches[1]:lower() == 'supersbanna' then
                    -- /ungban
                    if type(msg.reply_id) ~= "nil" then
                        if matches[2] then
                            if matches[2]:lower() == 'from' then
                                get_message(msg.reply_id, unbanall_from, { receiver = receiver, executer = msg.from.id })
                            else
                                get_message(msg.reply_id, unbanall_by_reply, { receiver = receiver, executer = msg.from.id })
                            end
                        else
                            get_message(msg.reply_id, unbanall_by_reply, { receiver = receiver, executer = msg.from.id })
                        end
                        return
                    elseif string.match(matches[2], '^%d+$') then
                        -- ignore higher or same rank
                        if compare_ranks(msg.from.id, matches[2], msg.to.id) then
                            unbanall_user(matches[2])
                            savelog(msg.to.id, "[" .. msg.from.id .. "] globally unbanned user " .. matches[2] .. " Y")
                            return lang_text('user') .. matches[2] .. lang_text('ungbanned')
                        else
                            savelog(msg.to.id, "[" .. msg.from.id .. "] globally unbanned user " .. matches[2] .. " N")
                            return lang_text('require_rank')
                        end
                    else
                        resolve_username(matches[2]:gsub('@', ''), unbanall_by_username, { executer = msg.from.id, chat_id = msg.to.id, receiver = receiver })
                    end
                    return
                end
                if matches[1]:lower() == 'gbanlist' or matches[1]:lower() == 'sasha lista superban' or matches[1]:lower() == 'lista superban' then
                    -- /gbanlist
                    local list = banall_list()
                    local file = io.open("./groups/gbanlist.txt", "w")
                    file:write(list)
                    file:flush()
                    file:close()
                    send_document(receiver, "./groups/gbanlist.txt", ok_cb, false)
                    send_large_msg(receiver, list)
                    return list
                end
            else
                return lang_text('require_support')
            end
        else
            return lang_text('require_owner')
        end
    else
        return lang_text('require_mod')
    end
end

local function pre_process(msg)
    local data = load_data(_config.moderation.data)
    -- SERVICE MESSAGE
    if msg.action and msg.action.type then
        local action = msg.action.type
        -- Check if banned user joins chat by link
        if action == 'chat_add_user_link' then
            local user_id = msg.from.id
            print('Checking invited user ' .. user_id)
            if is_banned(user_id, msg.to.id) or is_gbanned(user_id) then
                -- Check it with redis
                print('User is banned!')
                local print_name = user_print_name(msg.from):gsub("â€®", "")
                local name = print_name:gsub("_", "")
                savelog(msg.to.id, name .. " [" .. msg.from.id .. "] is banned and kicked ! ")
                -- Save to logs
                kick_user(user_id, msg.to.id)
            end
        end
        -- Check if banned user joins chat
        if action == 'chat_add_user' then
            local user_id = msg.action.user.id
            print('Checking invited user ' .. user_id)
            if is_banned(user_id, msg.to.id) and not is_momod2(msg.from.id, msg.to.id) or is_gbanned(user_id) and not is_admin2(msg.from.id) then
                -- Check it with redis
                print('User is banned!')
                local print_name = user_print_name(msg.from):gsub("â€®", "")
                local name = print_name:gsub("_", "")
                savelog(msg.to.id, name .. " [" .. msg.from.id .. "] added a banned user >" .. msg.action.user.id)
                -- Save to logs
                kick_user(user_id, msg.to.id)
                local banhash = 'addedbanuser:' .. msg.to.id .. ':' .. msg.from.id
                redis:incr(banhash)
                local banhash = 'addedbanuser:' .. msg.to.id .. ':' .. msg.from.id
                local banaddredis = redis:get(banhash)
                if banaddredis then
                    if tonumber(banaddredis) >= 4 and not is_owner(msg) then
                        kick_user(msg.from.id, msg.to.id)
                        -- Kick user who adds ban ppl more than 3 times
                    end
                    if tonumber(banaddredis) >= 8 and not is_owner(msg) then
                        ban_user(msg.from.id, msg.to.id)
                        -- Kick user who adds ban ppl more than 7 times
                        local banhash = 'addedbanuser:' .. msg.to.id .. ':' .. msg.from.id
                        redis:set(banhash, 0)
                        -- Reset the Counter
                    end
                end
            end
            if data[tostring(msg.to.id)] then
                if data[tostring(msg.to.id)]['settings'] then
                    if data[tostring(msg.to.id)]['settings']['lock_bots'] then
                        bots_protection = data[tostring(msg.to.id)]['settings']['lock_bots']
                    end
                end
            end
            if msg.action.user.username ~= nil then
                if string.sub(msg.action.user.username:lower(), -3) == 'bot' and not is_momod(msg) and bots_protection == "yes" then
                    --- Will kick bots added by normal users
                    local print_name = user_print_name(msg.from):gsub("â€®", "")
                    local name = print_name:gsub("_", "")
                    savelog(msg.to.id, name .. " [" .. msg.from.id .. "] added a bot > @" .. msg.action.user.username)
                    -- Save to logs
                    kick_user(msg.action.user.id, msg.to.id)
                end
            end
        end
        -- No further checks
        return msg
    end
    -- banned user is talking !
    if msg.to.type == 'chat' or msg.to.type == 'channel' then
        local group = msg.to.id
        local texttext = 'groups'
        -- if not data[tostring(texttext)][tostring(msg.to.id)] and not is_realm(msg) then -- Check if this group is one of my groups or not
        -- chat_del_user('chat#id'..msg.to.id,'user#id'..our_id,ok_cb,false)
        -- return
        -- end
        local user_id = msg.from.id
        local chat_id = msg.to.id
        if is_banned(user_id, msg.to.id) or is_gbanned(user_id) then
            -- Check it with redis
            print('Banned user talking!')
            local print_name = user_print_name(msg.from):gsub("â€®", "")
            local name = print_name:gsub("_", "")
            savelog(msg.to.id, name .. " [" .. msg.from.id .. "] banned user is talking !")
            -- Save to logs
            kick_user(user_id, chat_id)
            msg.text = ''
        end
    end
    return msg
end

return {
    description = "BANHAMMER",
    patterns =
    {
        "^[#!/]([Kk][Ii][Cc][Kk]) (.*)$",
        "^[#!/]([Kk][Ii][Cc][Kk])$",
		 "^[#!/]([Ss][Ii][Kk]) (.*)$",
        "^[#!/]([Ss][Ii][Kk])$",
        --"^[#!/]([Kk][Ii][Cc][Kk][Rr][Aa][Nn][Dd][Oo][Mm])$",
        "^[#!/]([Kk][Ii][Cc][Kk][Nn][Oo][Tt][Uu][Ss][Ee][Rr][Nn][Aa][Mm][Ee])$",
        "^[#!/]([Kk][Ii][Cc][Kk][Ii][Nn][Aa][Cc][Tt][Ii][Vv][Ee])$",
        "^[#!/]([Kk][Ii][Cc][Kk][Ii][Nn][Aa][Cc][Tt][Ii][Vv][Ee]) (%d+)$",
		 "^([Kk][Ii][Cc][Kk]) (.*)$",
        "^([Kk][Ii][Cc][Kk])$",
		 "^([Ss][Ii][Kk]) (.*)$",
        "^([Ss][Ii][Kk])$",
		 -- "^([Bb][Aa][Nn]) (.*)$",
      --  "^([Bb][Aa][Nn])$",
		--"^([Uu][Nn][Bb][Aa][Nn]) (.*)$",
        --"^([Uu][Nn][Bb][Aa][Nn])$",
        --"^([Kk][Ii][Cc][Kk][Rr][Aa][Nn][Dd][Oo][Mm])$",
        "^([Kk][Ii][Cc][Kk][Nn][Oo][Tt][Uu][Ss][Ee][Rr][Nn][Aa][Mm][Ee])$",
        "^([Kk][Ii][Cc][Kk][Ii][Nn][Aa][Cc][Tt][Ii][Vv][Ee])$",
        "^([Kk][Ii][Cc][Kk][Ii][Nn][Aa][Cc][Tt][Ii][Vv][Ee]) (%d+)$",
        "^!!tgservice (.+)$"

    },
    run = run,
    pre_process = pre_process,
    min_rank = 0
    -- usage
    -- (#kickme|sasha uccidimi)
    -- MOD
    -- (#kick|spara|[sasha] uccidi) <id>|<username>|<reply>|from
    -- (#ban|esplodi|kaboom|[sasha] banna|[sasha] decompila) <id>|<username>|<reply>|from
    -- (#unban|[sasha] sbanna|[sasha] [ri]compila) <id>|<username>|<reply>|from
    -- (#banlist|[sasha] lista ban)
    -- (#kickrandom|sasha uccidi random|spara random)
    -- (#kickdeleted|sasha uccidi eliminati|spara eliminati)
    -- OWNER
    -- (#kicknouser|sasha uccidi nouser|spara nouser)
    -- (#kickinactive [<msgs>]|((sasha uccidi)|spara sotto <msgs> messaggi))
    -- SUPPORT
    -- (#gban|[sasha] superbanna) <id>|<username>|<reply>|from
    -- (#ungban|[sasha] supersbanna) <id>|<username>|<reply>|from
    -- (#gbanlist|[sasha] lista superban)
    -- ADMIN
    -- (#banlist|[sasha] lista ban) <group_id>
}