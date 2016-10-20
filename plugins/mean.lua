local function run(msg, matches)
  local htp = http.request('http://api.vajehyab.com/v2/public/?q='..URL.escape(matches[1]))
  local data = json:decode(htp)
 return 'Word: '..(data.data.title or data.search.q)..'\n\nMean: '..(data.data.text or '----' )..'\n\nSoruce: '..(data.data.source or '----' )..'\n\n'..(data.error.message or '')..'\n\n'
end
return {
  patterns = {
    "^[!#/][Mm][Ee][Aa][Nn] (.*)$",
    "^[Mm][Ee][Aa][Nn] (.*)$"
  },
  run = run
}