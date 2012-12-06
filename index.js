require('coffee-script');
var server=require('./coffee-box')
  , http = require('http');

http.createServer(server).listen(server.get('port'),function(){
  console.log('coffee-box server listening on port '+server.get('port')+' in '+server.settings.env+' mode');
});