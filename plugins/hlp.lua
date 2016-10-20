local function run(msg, matches)
if matches[1]:lower == 'help' then
return "help:"
end
end
return {
patterns = {
"^([Hh]elp)$"
},
run = run
}