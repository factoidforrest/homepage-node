
express = require('express')
app = express()
handlers = require('./server/handlers')
sass = require('node-sass')
#database = require 'server/database'
#database.initialize(app)
sass.middleware({
  src: __dirname + '/public/stylesheets',
  dest: __dirname + '/public/stylesheets/css',
  debug: true #,
  #outputStyle: 'compressed'
  #, prefix:  '/prefix'
})
#static assets
app.use(express.static(__dirname + '/public'));

app.get('/', handlers.root)


app.listen(process.env.PORT || 3000);