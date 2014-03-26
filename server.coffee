
express = require('express')
app = express()
#coffeeMiddleware = require('coffee-middleware')
coffeescript = require('connect-coffee-script')
handlers = require('./server/handlers')
sass = require('node-sass')
orm = require('./server/ORM')(app)
orm.sync()

#engines = require('consolidate')
#sassMiddleware = require('sass-middleware')

#database = require 'server/database'
#database.initialize(app)
#app.set('views', __dirname + '/public')
app.set('views', __dirname + '/views')
app.use(express.logger())

app.locals.uglify = false
#app.engine 'hamlc', require('haml-coffee').__express
app.set('view engine', 'jade')
app.use(
  sass.middleware({
    src: __dirname + '/views/stylesheets',
    dest: __dirname + '/public',
    debug: true,
    outputStyle: 'compressed'
  })
)
###
app.use(
  coffeeMiddleware({
    src: __dirname + '/public/scripts',
    compress: false,
    debug: true,
    bare: true #needed for require.js compatability 
  })
)
###
app.use(coffeescript({
  src: __dirname + '/views/js',
  dest: __dirname + '/public/js',
  bare: true
}))

#static assets
app.use(express.static(__dirname + '/public'))

#static file routes
app.get('/', handlers.root)

app.listen(process.env.PORT || 3000)

