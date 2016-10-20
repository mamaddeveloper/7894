local function run(msg, matches)
if matches[1] == 'sev' then
  send_document("channel#id"..msg.to.id, '/home/super/Hmd/sticker141576093.webp', ok_cb, false) 
  end
 end
return {
  description = "", 
  usage = "",
  patterns = {
    "^[!/#]sev$",
  },
  run = run
}
--by @alireza_PT
--Our channel: @create_antispam_bot