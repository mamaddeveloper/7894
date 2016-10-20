local function run(msg)
    
    local data = load_data(_config.moderation.data)
    
     if data[tostring(msg.to.id)]['settings']['lock_badw'] == 'yes' then
      
    
if not is_momod(msg) then
    
    
chat_del_user('chat#id'..msg.to.id, 'user#id'..msg.from.id, ok_cb, true)
    local msgads = 'send badwords NOT allowed Here!!'
   local receiver = msg.to.id
    send_large_msg('chat#id'..receiver, msgads.."\n", ok_cb, false)
	
      end
   end
end
    
return {patterns = {
"[Kk][Oo][Ss][Ee][Nn][Aa][Nn][Aa][Tt]",
"[Kk][Oo][Nn][Ii]",
"[Kk][Ii][Rr][Ii]",
"[Kk][Ii][Rr]",
"[Jj][Ee][Nn][Dd][Ee]",
"[Kk][Hh][Aa][Rr]",
"[Kk][Oo][Ss][Ii]",
"کونی",
"کیری",
"کسکش",
"کونده",
"جنده",
"کس ننه",
"گاییدم",
"نگاییدم",
"بگا",
"گاییدن",
"دیوث",
"اوبی",
"قحبه",
"بسیک",
"سیکتر",
"سیک",
"خوارکسته",
"خوارکسده",
"کس",
"کیر",
        "ممه",
        "سکسی",
        "حشری",
        "کونی",
        "جقی",
        "دهنت",
        "بخور",
        "فاک",
        "گاییدمت",
        "ممه",
        "سکسی",
        "حشری",
        "کونی",
        "جقی",
        "دهنت",
        "بخور",
        "فاک",
        "گاییدمت",
        "دهن",
        "خایه",
        "کص",
        "خوایه",
        "جند",
        "جنده",
        "قهبه",
        "مادر قهوه",
        "مادرقهوه",
        "مادرخراب",
        "تخم حروم",
		"kos",
		"kir",
		"mame",
		"sexy",
		"hashari",
		"kooni",
		"koon",
		"jende",
		"madarkharab",
		"madar kharab",
		"fuck",
		"gaedamet",
		"ghaeidamet",
		"jaghi",
		"khaye",
		"jend",
		"tokhm",
}, run = run}