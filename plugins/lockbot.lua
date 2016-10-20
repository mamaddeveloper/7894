local function run(msg, matches)
 local data = load_data(_config.moderation.data)
 if data[tostring(msg.to.id)] then
    if data[tostring(msg.to.id)]['settings'] then
        if data[tostring(msg.to.id)]['settings']['lock_bots'] then
           lock_bots = data[tostring(msg.to.id)]['settings']['lock_bots']
          end
      end
    end
if lock_bots == 'yes' then
 if matches[1] == 'channel_invite' or 'chat_add_user' then
   if msg.action.user.username ~= nil then
      if string.sub(msg.action.user.username:lower(), -3) == 'bot' then
   kick_user(msg.action.user.id, msg.to.id)
   end
 end
end
end
end
return {
 patterns = {
   "^!!tgservice (channel_invite)$",
   "^!!tgservice (chat_add_user)$"
  },
  run = run
}