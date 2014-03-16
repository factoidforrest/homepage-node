mysql = require('mysql')

class Database

  handleDisconnect: =>
    self = this
    @connection = mysql.createConnection(@options) # Recreate the connection, since
    # the old one cannot be reused.
    @connection.connect (err) -> # The server is either down
      if err # or restarting (takes a while sometimes).
        console.log "error when connecting to db, retrying:", err
        setTimeout self.handleDisconnect, 2000 # We introduce a delay before attempting to reconnect,
      else
        console.log("database connected")
        self.connection.emit('connected')

    # to avoid a hot loop, and to allow our node script to
    # process asynchronous requests in the meantime.
    # If you're also serving http, display a 503 error.
    @connection.on "error", (err) ->
      console.log "db error", err
      if err.code is "PROTOCOL_CONNECTION_LOST" # Connection to the MySQL server is usually
        self.handleDisconnect() # lost due to either server restart, or a
      else # connnection idle timeout (the wait_timeout
        throw err # server variable configures this)

  connect: (callback)=> 
    if @connection.status == 'connected'
      callback(null, @connection)
    else
      console.log("ATTEMPTED TO USE DISCONNECTED DB, setting retry listener")
      #untested, only tries once more
      @connection.on 'connected', retry = (event)->
        e.source.removeEventListener('connected', arguments.callee)
        callback(null,@connection)


  constructor: (app)->
    self = this
    app.configure 'development', ->
      self.options = 
        host: 'localhost',
        user: 'forrest'
    app.configure 'production', ->
      throw new Error("database not yet setup for production")
    @handleDisconnect()


module.exports = Database