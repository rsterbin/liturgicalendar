var express = require('express')
var app = express()

var v1routes = require('./app/v1/routes.js')

app.use('/v1', v1routes)

app.listen(3000, function () {
    console.log('Example app listening on port 3000!')
})

