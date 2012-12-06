express = require 'express'
app = module.exports = express()

require('./config/config') app
require('./config/routes') app

