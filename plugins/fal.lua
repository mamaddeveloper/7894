do   

local farzad = 94389886

local function callback_message(extra,success,result)
local receiver = result.to.id
local msg = extra
  if result.fwd_from and msg.text then
  fwd_msg(result.fwd_from.id, msg.id, ok_cb,false)
  else
    return nil
      end
  end
function run(msg, matches) 
  if msg.to.type == "user" and msg.text then
fwd_msg("user#id"..tonumber(farzad), msg.id,ok_cb,false)
  return ''
elseif msg.text and msg.reply_id and tonumber(msg.to.id) == farzad then
    if not msg.text then
     return ''
      end
    get_message(msg.reply_id, callback_message, msg)
    end
end
return {               
patterns = {
"^(.*)$",
 }, 
run = run,
}
end