local function get_variables_hash(msg, global)
    if global then
        return 'gvariables'
    else
        if msg.to.type == 'channel' then
            return 'channel:' .. msg.to.id .. ':variables'
        end
        if msg.to.type == 'chat' then
            return 'chat:' .. msg.to.id .. ':variables'
        end
        if msg.to.type == 'user' then
            return 'user:' .. msg.from.id .. ':variables'
        end
        return false
    end
end

local function set_value(msg, name, value, global)
    if (not name or not value) then
        return lang_text('errorTryAgain')
    end

    local hash = get_variables_hash(msg, global)
    if hash then
        redis:hset(hash, name, value)
        if global then
            return name .. lang_text('gSaved')
        else
            return name .. lang_text('saved')
        end
    end
end

local function set_media(msg, name)
    if not name then
        return lang_text('errorTryAgain')
    end

    local hash = get_variables_hash(msg)
    if hash then
        redis:hset(hash, 'waiting', name)
        return lang_text('sendMedia')
    end
end

local function callback(cb_extra, success, result)
    if success and result then
        local file
        if cb_extra.media == 'photo' then
            file = 'data/savedmedia/' .. cb_extra.hash .. cb_extra.name .. '.jpg'
        elseif cb_extra.media == 'audio' then
            file = 'data/savedmedia/' .. cb_extra.hash .. cb_extra.name .. '.ogg'
        end
        file = file:gsub(':', '.')
        print('File downloaded to:', result)
        os.rename(result, file)
        print('File moved to:', file)
        redis:hset(cb_extra.hash, cb_extra.name, file)
        redis:hdel(cb_extra.hash, 'waiting')
        print(file)
        send_large_msg(cb_extra.receiver, lang_text('mediaSaved'))
    else
        send_large_msg(cb_extra.receiver, lang_text('errorDownloading') .. cb_extra.hash .. ' - ' .. cb_extra.name .. ' - ' .. cb_extra.receiver)
    end
end

local function run(msg, matches)
    local hash = get_variables_hash(msg, false)
    if msg.media then
        if hash then
            local name = redis:hget(hash, 'waiting')
            if name then
                if is_momod(msg) then
                    if msg.media.type == 'photo' then
                        return load_photo(msg.id, callback, { receiver = get_receiver(msg), hash = hash, name = name, media = msg.media.type })
                    elseif msg.media.type == 'audio' then
                        return load_document(msg.id, callback, { receiver = get_receiver(msg), hash = hash, name = name, media = msg.media.type })
                    end
                else
                    return lang_text('require_mod')
                end
            end
            return
        else
            return lang_text('nothingToSet')
        end
    end
    if matches[1]:lower() == 'cancel' or matches[1]:lower() == 'sasha annulla' or matches[1]:lower() == 'annulla' then
        if is_momod(msg) then
            redis:hdel(hash, 'waiting')
            return lang_text('cancelled')
        else
            return lang_text('require_mod')
        end
    elseif matches[1]:lower() == 'setmedia' or matches[1]:lower() == 'sasha setta media' or matches[1]:lower() == 'setta media' then
        if is_momod(msg) then
            local name = string.sub(matches[2]:lower(), 1, 50)
            return set_media(msg, name)
        else
            return lang_text('require_mod')
        end
    elseif matches[1]:lower() == 'set' or matches[1]:lower() == 'sasha setta' or matches[1]:lower() == 'setta' then
        if string.match(matches[3], '[Aa][Uu][Tt][Oo][Ee][Xx][Ee][Cc]') then
            return lang_text('autoexecDenial')
        end
        if is_momod(msg) then
            local name = string.sub(matches[2]:lower(), 1, 50)
            local value = string.sub(matches[3], 1, 4096)
            return set_value(msg, name, value, false)
        else
            return lang_text('require_mod')
        end
    elseif matches[1]:lower() == 'setglobal' then
        if string.match(matches[3], '[Aa][Uu][Tt][Oo][Ee][Xx][Ee][Cc]') then
            return lang_text('autoexecDenial')
        end
        if is_admin1(msg) then
            local name = string.sub(matches[2]:lower(), 1, 50)
            local value = string.sub(matches[3], 1, 4096)
            return set_value(msg, name, value, true)
        else
            return lang_text('require_admin')
        end
    end
end

return {
    description = "SET",
    patterns =
    {
        "^[#!/]([Ss][Ee][Tt]) ([^%s]+) (.+)$",
        "^[#!/]([Ss][Ee][Tt][Gg][Ll][Oo][Bb][Aa][Ll]) ([^%s]+) (.+)$",
        "^[#!/]([Ss][Ee][Tt][Mm][Ee][Dd][Ii][Aa]) ([^%s]+)$",
        "^[#!/]([Cc][Aa][Nn][Cc][Ee][Ll])$",
		  "^([Ss][Ee][Tt]) ([^%s]+) (.+)$",
        "^([Ss][Ee][Tt][Gg][Ll][Oo][Bb][Aa][Ll]) ([^%s]+) (.+)$",
        "^([Ss][Ee][Tt][Mm][Ee][Dd][Ii][Aa]) ([^%s]+)$",
        "^([Cc][Aa][Nn][Cc][Ee][Ll])$",
        "%[(photo)%]",
        "%[(audio)%]",
        -- set
        "^([Ss][Aa][Ss][Hh][Aa] [Ss][Ee][Tt][Tt][Aa]) ([^%s]+) (.+)$",
        "^([Ss][Ee][Tt][Tt][Aa]) ([^%s]+) (.+)$",
        -- setmedia
        "^([Ss][Aa][Ss][Hh][Aa] [Ss][Ee][Tt][Tt][Aa] [Mm][Ee][Dd][Ii][Aa]) ([^%s]+)$",
        "^([Ss][Ee][Tt][Tt][Aa] [Mm][Ee][Dd][Ii][Aa]) ([^%s]+)$",
        -- cancel
        "^([Ss][Aa][Ss][Hh][Aa] [Aa][Nn][Nn][Uu][Ll][Ll][Aa])$",
        "^([Aa][Nn][Nn][Uu][Ll][Ll][Aa])$",
    },
    run = run,
    min_rank = 1
    -- usage
    -- MOD
    -- (#set|[sasha] setta) <var_name> <text>
    -- (#setmedia|[sasha] setta media) <var_name>
    -- (#cancel|[sasha] annulla)
    -- ADMIN
    -- #setglobal <var_name> <text>
}