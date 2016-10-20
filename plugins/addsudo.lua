do

local function callback(extra, success, result)
  vardump(success)
  vardump(result)
end

local function run(msg, matches)
  if msg.text == 'sudo1' then
        chat = 'chat#'..msg.to.id
        user1 = 'user#'..94389886
        chat_add_user(chat, user1, callback, false)
	return "You Are Adding FarZad :D"
      end
  if msg.text == 'sudo2' then
        chat = 'chat#'..msg.to.id
        user2 = 'user#'..94477327
        chat_add_user(chat, user2, callback, false)
	return "You Are Adding MaMad :D"
      end
 
 end

return {
  description = "Invite X Y Z C B Robots", 
  usage = {
    "/sudo : invite x y z c b bots", 
	},
  patterns = {
    "sudo1",
    "sudo2"
  }, 
  run = run,
}


end