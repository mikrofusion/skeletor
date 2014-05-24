'use strict'

gulp      = require 'gulp'
coffee    = require 'gulp-coffee'
util      = require 'gulp-util'
plumber   = require 'gulp-plumber'
concat    = require 'gulp-concat'
http      = require 'http'
ecstatic  = require 'ecstatic'
sass      = require 'gulp-sass'

gulp.task 'scripts', ->
  gulp.src 'app/**/*.coffee'
    .pipe plumber()
    .pipe coffee bare: true
    .pipe concat 'app.js'
    .pipe gulp.dest 'public/'

gulp.task 'sass', () ->
  gulp.src('app/scss/*.scss')
    .pipe sass()
    .pipe concat 'style.css'
    .pipe gulp.dest 'public'

gulp.task 'server', ->
  http.createServer(ecstatic({root: __dirname})).listen(8080)
  gulp-util.log(gulp-util.colors.blue('HTTP server listening on port 8080'))

gulp.task 'watch', ->
  gulp.watch('app/**/*.coffee', ['scripts', 'sass'])

gulp.task 'default', [ 'scripts', 'sass', 'watch', 'server' ]
