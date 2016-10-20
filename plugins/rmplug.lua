local function run(msg, matches)
    if matches[1] == "del" and is_sudo(msg) then
text = io.popen("cd plugins && rm "..matches[2]..".lua")
return 'File '..matches[2]..' has been deleted.'

end 
end

return { 
patterns = {
'^(del) (.*)$', 
'^[!/](del) (.*)$'
},
run = run
}