do

function run(msg, matches)
    local data = load_data(_config.moderation.data)
      local group_link = data[tostring(1042133919)]['settings']['set_link']
       if not group_link then
      return '*First write new link to create Link!*'
       end
         local text = "Support Gp, Link:\n\n"..group_link
         return text
end

return {
  patterns = {
    "^[!/]([Ll]inksp)$",
	"^([Ll]inksp)$"
  },
  run = run
}

end
