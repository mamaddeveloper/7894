do
local function run(msg, matches)
  local url = "http://www.farsireader.com/PlayText.aspx?Text="..matches[1]
  local receiver = get_receiver(msg)
  local file = download_to_file(url,'text.ogg')
      send_audio('chat#id'..msg.to.id, file, ok_cb , false)
end

return {
  description = "text to voice",
  usage = {
    "!voice [text]"
  },
  patterns = {
    "^[!/#]fa (.+)$",
	"^fa (.+)$",
	"^[!/#]fav (.+)$",
	"^fav (.+)$"
  },
  run = run
}

end
  
  