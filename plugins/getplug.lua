do

local function run(msg, matches)
  if matches[1] == "getplug" then
    local file = matches[2]
    if is_sudo(msg) then
      local receiver = get_receiver(msg)
      send_document(receiver, "/home/super/Hmd/plugins/"..file..".lua", ok_cb, false)
    end
  end
end

return {
  patterns = {
  "^#(getplug) (.*)$",
  "^(getplug) (.*)$"
  },
  run = run
}
end