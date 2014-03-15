mysql = require('mysql')

connection
options

createDB = ()->
	connection = mysql.createConnection(options).connect((err)->
		#callback(err)
		throw err if err
	)
	return connection

module.exports = [
 	connect: (callback)-> 
    if !connection 
    	connection = createDB()
    callback(null, connection)
	,
	initalize: (app)->
		app.configure('development', ->
			options = 
				host: 'localhost',
				user: 'me',
				password: 'secret'
			)
	,
	]







