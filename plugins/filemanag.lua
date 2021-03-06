local BASE_FOLDER = "/home/super/Hmd/"

local function callback(extra, success, result)
    if success then
        send_large_msg('chat#id' .. extra, lang_text('fileDownloadedTo') .. result)
        send_large_msg('channel#id' .. extra, lang_text('fileDownloadedTo') .. result)
    else
        send_large_msg('chat#id' .. extra, lang_text('errorDownloading') .. extra)
        send_large_msg('channel#id' .. extra, lang_text('errorDownloading') .. extra)
    end
end

function run(msg, matches)
    if is_sudo(msg) then
        local folder = redis:get('folder')
        if folder then
            receiver = get_receiver(msg)
            if matches[1]:lower() == 'folder' then
                return lang_text('youAreHere') .. BASE_FOLDER .. folder
            end
            if matches[1]:lower() == 'cd' then
                if not matches[2] then
                    redis:set('folder', '')
                    return lang_text('backHomeFolder') .. BASE_FOLDER
                else
                    redis:set('folder', matches[2])
                    return lang_text('youAreHere') .. BASE_FOLDER .. matches[2]
                end
            end
            local action = ''
            if matches[1]:lower() == 'ls' then
                action = io.popen('ls "' .. BASE_FOLDER .. folder .. '"'):read("*all")
            end
            if matches[1]:lower() == 'mkdir' and matches[2] then
                action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && mkdir \'' .. matches[2] .. '\''):read("*all")
                return lang_text('folderCreated'):gsub("X", matches[2])
            end
            if matches[1]:lower() == 'rm' and matches[2] then
                action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && rm -f \'' .. matches[2] .. '\''):read("*all")
                return matches[2] .. lang_text('deleted')
            end
            if matches[1]:lower() == 'cat' and matches[2] then
                action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && cat \'' .. matches[2] .. '\''):read("*all")
            end
            if matches[1]:lower() == 'rmdir' and matches[2] then
                action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && rmdir \'' .. matches[2] .. '\''):read("*all")
                return lang_text('folderDeleted'):gsub("X", matches[2])
            end
            if matches[1]:lower() == 'touch' and matches[2] then
                action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && touch \'' .. matches[2] .. '\''):read("*all")
                return matches[2] .. lang_text('created')
            end
            if matches[1]:lower() == 'tofile' and matches[2] and matches[3] then
                file = io.open(BASE_FOLDER .. folder .. matches[2], "w")
                file:write(matches[3])
                file:flush()
                file:close()
                send_large_msg(receiver, lang_text('fileCreatedWithContent'):gsub("X", matches[3]))
            end
            if matches[1]:lower() == 'shell' and matches[2] then
                action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && ' .. matches[2]:gsub('—', '--')):read('*all')
            end
            if matches[1]:lower() == 'cp' and matches[2] and matches[3] then
                action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && cp -r \'' .. matches[2] .. '\' \'' .. matches[3] .. '\''):read("*all")
                return matches[2] .. lang_text('copiedTo') .. matches[3]
            end
            if matches[1]:lower() == 'mv' and matches[2] and matches[3] then
                action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && mv \'' .. matches[2] .. '\' \'' .. matches[3] .. '\''):read("*all")
                return matches[2] .. lang_text('movedTo') .. matches[3]
            end
            if matches[1]:lower() == 'upload' and matches[2] then
                if io.popen('find ' .. BASE_FOLDER .. folder .. matches[2]):read("*all") == '' then
                    return matches[2] .. ' Not Find'
                else
                    send_document(receiver, BASE_FOLDER .. folder .. matches[2], ok_cb, false)
                    return 'Sending Your ' .. matches[2]
                end
            end
            if matches[1]:lower() == 'download' then
                if type(msg.reply_id) == "nil" then
                    return lang_text('useQuoteOnFile')
                else
                    load_document(msg.reply_id, callback, msg.to.id)
                end
            end
            send_large_msg(receiver, action)
        else
            redis:set('folder', '')
        end
    else
        return lang_text('require_sudo')
    end
end

return {
    description = "FILEMANAGER",
    patterns =
    {
        "^[#!/]([Ff][Oo][Ll][Dd][Ee][Rr])$",
        "^[#!/]([Cc][Dd])$",
        "^[#!/]([Cc][Dd]) (.*)$",
        "^[#!/]([Ll][Ss])$",
        "^[#!/]([Mm][Kk][Dd][Ii][Rr]) (.*)$",
        "^[#!/]([Rr][Mm][Dd][Ii][Rr]) (.*)$",
        "^[#!/]([Rr][Mm]) (.*)$",
        "^[#!/]([Tt][Oo][Uu][Cc][Hh]) (.*)$",
        "^[#!/]([Cc][Aa][Tt]) (.*)$",
        "^[#!/]([Tt][Oo][Ff][Ii][Ll][Ee]) ([^%s]+) (.*)$",
        "^[#!/]([Ss][Hh][Ee][Ll][Ll]) (.*)$",
        "^[#!/]([Cc][Pp]) (.*) (.*)$",
        "^[#!/]([Mm][Vv]) (.*) (.*)$",
        "^[#!/]([Uu][Pp][Ll][Oo][Aa][Dd]) (.*)$",
        "^[#!/]([Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd])",
		 "^([Ff][Oo][Ll][Dd][Ee][Rr])$",
        "^([Cc][Dd])$",
        "^([Cc][Dd]) (.*)$",
        "^([Ll][Ss])$",
        "^([Mm][Kk][Dd][Ii][Rr]) (.*)$",
        "^([Rr][Mm][Dd][Ii][Rr]) (.*)$",
        "^([Rr][Mm]) (.*)$",
        "^([Tt][Oo][Uu][Cc][Hh]) (.*)$",
        "^([Cc][Aa][Tt]) (.*)$",
        "^([Tt][Oo][Ff][Ii][Ll][Ee]) ([^%s]+) (.*)$",
        "^([Ss][Hh][Ee][Ll][Ll]) (.*)$",
        "^([Cc][Pp]) (.*) (.*)$",
        "^([Mm][Vv]) (.*) (.*)$",
        "^([Uu][Pp][Ll][Oo][Aa][Dd]) (.*)$",
        "^([Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd])"
    },
    run = run,
    min_rank = 4
    -- usage
    -- SUDO
    -- #folder
    -- #cd [<directory>]
    -- #ls
    -- #mkdir <directory>
    -- #rmdir <directory>
    -- #rm <file>
    -- #touch <file>
    -- #cat <file>
    -- #tofile <file> <text>
    -- #shell <command>
    -- #cp <file> <directory>
    -- #mv <file> <directory>
    -- #upload <file>
    -- #download <reply>
}
-- Thanks to @imandaneshi