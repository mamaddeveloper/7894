-- Will leave the group if be added
local function run(msg, matches)
    if matches[1]:lower() == 'l' or matches[1]:lower() == 'sasha abbandona' then
        if is_sudo(msg) then
            if not matches[2] then
                leave_channel(get_receiver(msg), ok_cb, false)
            else
                leave_channel("channel#id" .. matches[2], ok_cb, false)
            end
        else
            return langs[msg.lang].require_admin
        end
    elseif msg.service and msg.action.type == "chat_add_user" and msg.action.user.id == tonumber(our_id) and not is_admin1(msg) then
        leave_channel(get_receiver(msg), ok_cb, false)
        return langs[msg.lang].notMyGroup
    end
end

return {
    description = "ONSERVICE",
    patterns =
    {
        "^[#!/](l) (%d+)$",
        "^[#!/](l)$",
		  "^(l) (%d+)$",
        "^(l)$",
        -- leave
        "^([Ss][Aa][Ss][Hh][Aa] [Aa][Bb][Bb][Aa][Nn][Dd][Oo][Nn][Aa]) (%d+)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Aa][Bb][Bb][Aa][Nn][Dd][Oo][Nn][Aa])$",
        "^!!tgservice (.+)$",
    },
    run = run
}