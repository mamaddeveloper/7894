local function run(msg, matches)
local text = matches[2]
if matches[1]:lower() == 'mk' then
return text
end
end
return {
patterns = {
  "^[/!#]([Mm][Kk]) (.*)$",
  "^([Mm][Kk]) (.*)$"
 },
   run = run
 }