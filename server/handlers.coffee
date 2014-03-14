haml = require('haml')
fs = require('fs')
aDay = 86400000;
staticOpts = {maxAge: aDay}


build = (path, data) ->
	template = fs.readFileSync(path, 'utf8')
	html = haml.render(template, {locals: data})
	return html

module.exports = {
	root: (req, res) ->
		html = build('public/layout.haml', null)
		res.send(html)
 }