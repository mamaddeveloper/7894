do

function run(msg, matches)
       if not is_momod(msg) then
        return "Just For Admins"
       end
    local data = load_data(_config.moderation.data)
      local group_link = data[tostring(msg.to.id)]['settings']['set_link']
       if not group_link then 
        return "First, You must Creat Link with /newlink"
       end
         local text = "GroupLink:\n"..group_link
          send_large_msg('user#id'..msg.from.id, text.."\n", ok_cb, false)
           return "Group Link sent your Pv"
end

return {
  patterns = {
    "^[/#!]([Ll]inkpv)$",
	"^([Ll]inkpv)$"
  },
  run = run
}

end