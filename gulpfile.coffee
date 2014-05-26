'use strict'

gulp      = require 'gulp'
coffee    = require 'gulp-coffee'
util      = require 'gulp-util'
plumber   = require 'gulp-plumber'
concat    = require 'gulp-concat'
http      = require 'http'
ecstatic  = require 'ecstatic'
sass      = require 'gulp-sass'
jade      = require 'gulp-jade'
uglify    = require 'gulp-uglify'
obfuscate = require 'gulp-obfuscate'

onError = (err) ->
  util.log util.colors.red 'stream error...'
  util.log util.colors.red(JSON.stringify(err))
  util.beep()

gulp.task 'scripts', ->
  gulp.src 'app/**/*.coffee'
    .pipe plumber({errorHandler: onError})
    .pipe coffee bare: true
    .pipe concat 'app.js'
    #.pipe obfuscate()
    #.pipe uglify mangle:false
    .pipe gulp.dest 'public/'

gulp.task 'templates', () ->
  gulp.src './app/templates/*.jade'
    .pipe plumber({errorHandler: onError})
    .pipe jade pretty: true
    .pipe gulp.dest 'public/templates/'

gulp.task 'sass', () ->
  gulp.src('app/scss/*.scss')
    .pipe plumber({errorHandler: onError})
    .pipe sass()
    .pipe concat 'style.css'
    .pipe gulp.dest 'public/css/'

gulp.task 'server', ->
  http.createServer(ecstatic({root: __dirname})).listen 8080
  util.log util.colors.blue 'HTTP server listening on port 8080'

gulp.task 'watch', ->
  gulp.watch 'app/**/*.*', ['compile']

gulp.task 'compile', [ 'scripts', 'sass', 'templates' ]
gulp.task 'default', [ 'compile', 'watch', 'server' ]
