function run(msg, matches)
text = io.popen("figlet " .. matches[1]):read('*all')
  return text
end
return {
  patterns = {
    '^[#/!][Tt]a (.*)$',
	'^[Tt]a (.*)$'
  },
  run = run,
  moderated = true
}