#!/usr/bin/env node
var stitch  = require('stitch'),
    express = require('express'),
    util    = require('util'),
    fs      = require('fs'),
    argv    = process.argv.slice(2);
    
stitch.compilers.tmpl = function(module, filename) {
  var content = fs.readFileSync(filename, 'utf8');
  content = ["var template = jQuery.template(", JSON.stringify(content), ");", 
             "module.exports = (function(data){ return jQuery.tmpl(template, data); });\n"].join("");
  return module._compile(content, filename);
};

var package = stitch.createPackage({
  paths: [__dirname + '/app'],
  dependencies: [
    __dirname + '/lib/jquery.js',
    __dirname + '/lib/jquery.tmpl.js',
    __dirname + '/lib/spine.js',
    __dirname + '/lib/spine.tmpl.js',
    __dirname + '/lib/spine.manager.js',
    __dirname + '/lib/spine.ajax.js',
    __dirname + '/lib/spine.local.js',
    __dirname + '/lib/spine.route.js',
    __dirname + '/lib/spine.touch.js',
    __dirname + '/lib/gfx.js'
  ]
});

if (argv[0] == "build") {
  return package.compile(function (err, source){
    fs.writeFile(__dirname + '/public/application.js', source, function (err) {
      if (err) throw err;
      console.log('Compiled application.js');
    })
  });
}

var app = express.createServer();

app.configure(function() {
  app.set('views', __dirname + '/views');
  app.use(express.compiler({ src: __dirname + '/public', enable: ['less'] }));
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
  app.get('/application.js', package.createServer());
});

var port = argv[0] || process.env.PORT || 9294;
util.puts("Starting server on port: " + port);
app.listen(port);