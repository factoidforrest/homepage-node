
express = require('express')
app = express()
handlers = require('./server/handlers')
#engines = require('consolidate')
#sassMiddleware = require('sass-middleware')

#database = require 'server/database'
#database.initialize(app)
app.set('views', __dirname + '/public')
#app.engine('haml', require('hamljs').renderFile)
app.engine 'hamlc', require('haml-coffee').__express
app.use(require('sass-middleware')({
  bin: 'sass',
  src: 'public/stylesheets'#,
  #quiet: true
}))
app.use(coffeeMiddleware({
    src: __dirname + '/public/scripts',
    compress: false
}))

app.locals.uglify = false

#static assets
app.use(express.static(__dirname + '/public'))

#static file routes
app.get('/', handlers.root)




app.listen(process.env.PORT || 3000)