
express = require('express')
app = express()
coffeeMiddleware = require('coffee-middleware')
handlers = require('./server/handlers')
sass = require('node-sass')
database = require('./server/database')
console.log("about to start orm")
orm = require('./server/ORM')(app)
orm.sync()
looper = ->

#engines = require('consolidate')
#sassMiddleware = require('sass-middleware')

#database = require 'server/database'
#database.initialize(app)
#app.set('views', __dirname + '/public')
app.use(express.logger())

app.locals.uglify = false
app.engine 'hamlc', require('haml-coffee').__express

app.use(
  sass.middleware({
    src: __dirname + '/views/stylesheets',
    dest: __dirname + '/public',
    debug: true,
    outputStyle: 'compressed'
  })
)

app.use(coffeeMiddleware({
    src: __dirname + '/views/scripts',
    dest: __dirname + '/public'
    compress: false
}))


#static assets
app.use(express.static(__dirname + '/public'))

#static file routes
app.get('/', handlers.root)

app.listen(process.env.PORT || 3000)

