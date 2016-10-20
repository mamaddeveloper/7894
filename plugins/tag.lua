local function run(msg, matches)
if msg.to.type == 'chat' then
    if is_owner(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['tag'] then
                tag = data[tostring(msg.to.id)]['settings']['tag']
            end
        end
    end
    local chat = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if tag == "yes" then
        send_large_msg(chat, 'Tag is not allowed here!!')
        chat_del_user(chat, user, ok_cb, true)
    end
end
 end
return {
  patterns = {
	"#"
  },
  run = run
}
