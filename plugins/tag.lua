
--An empty table for solving multiple kicking problem(thanks to @topkecleon )
kicktable = {}
local function run(msg, matches)
if msg.to.type == 'channel' then
    if is_momod(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['lock_tag'] then
                lock_tag = data[tostring(msg.to.id)]['settings']['lock_tag']
            end
        end
	end
    if lock_tag == "yes" then
        delete_msg(msg.id, ok_cb, false)
			if strict == "yes" then
		     kick_user(msg.from.id, msg.to.id)
		 end
      end
   end
 end
return {
 usage = {
  "lock tag: If User Send A Message With # , @ Then Bot Removed User.",
  "unlock tag: No Action Execute If User Send Mesage With # , @",
  },
  patterns = {
 "#(.*)",
 "(.*)#",
 "^#",
 "^#[^%s]+",
 "^[^%s]+#",
 "^#[%a%d]"
 },
  run = run
}