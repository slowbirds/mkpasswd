gulp       = require 'gulp'
jade       = require 'gulp-jade'
coffee     = require 'gulp-coffee'
uglify     = require 'gulp-uglify'
stylus     = require 'gulp-stylus'
minify     = require 'gulp-minify-css'
concat     = require 'gulp-concat'
watch      = require 'gulp-watch'
server     = require 'gulp-webserver'
livereload = require 'gulp-livereload'
plumber    = require 'gulp-plumber'
notify     = require 'gulp-notify'
imagemin   = require 'gulp-imagemin'
rename     = require 'gulp-rename'
buffer     = require 'vinyl-buffer'
filter     = require 'gulp-filter'

browserify = require 'browserify'
coffeeify  = require 'coffeeify'
source     = require 'vinyl-source-stream'
streamify  = require 'gulp-streamify'
sourcemaps = require 'gulp-sourcemaps'
pleeease   = require 'gulp-pleeease'

mocha      = require 'gulp-mocha'
gutil      = require 'gulp-util'

pub_dir    = 'app/public'

srcdata = {
  'coffee'   : 'source/coffee/**/*.coffee'
  'stylus'   : 'source/stylus/**/*.stylus'
  'jade'     : 'source/jade/**/*.jade'
  'bower'    : ['dev/vendors/**/*','bower_components/**/*']
  'vendorjs' : 'source/javascript/**/*'
  'resource' : 'source/resource/**/*'
  'tests'    : 'source/coffee/tests/**/*.test.coffee'
}

gulp.task 'compile-js', () ->
  compileFileName = 'application.min.js'
  browserify(
    entries: ['./source/coffee/main.coffee']
    extensions: ['.coffee']
    )
    .transform 'coffeeify'
    .bundle()
    .pipe plumber(errorHandler: notify.onError '<%= error.message %>')
    .pipe source 'application.min.js'
    .pipe buffer()
    .pipe sourcemaps.init
      loadMaps: true
    .pipe streamify uglify({mangle: false})
    .pipe sourcemaps.write(pub_dir+'/scripts')
    .pipe gulp.dest pub_dir+'/scripts'

gulp.task 'compile-css', () ->
  compileFileName = 'application.min.css'
  gulp.src srcdata.stylus
    .pipe plumber(errorHandler: notify.onError '<%= error.message %>')
    .pipe sourcemaps.init()
    .pipe stylus()
    .pipe concat(compileFileName)
    .pipe pleeease
      fallbacks:
        autoprefixer: ['last 4 versions']
      optimizers:
        minifier: false
#    .pipe minify()
    .pipe sourcemaps.write(pub_dir+'/styles')
    .pipe gulp.dest(pub_dir+'/styles')

gulp.task 'compile-html', () ->
  gulp.src srcdata.jade
    .pipe plumber(errorHandler: notify.onError '<%= error.message %>')
    .pipe jade
      pretty: true
    .pipe rename extname: '.html'
    .pipe gulp.dest(pub_dir)

gulp.task 'move-vendors', () ->
  cssFilter = filter '**/*.css'
  gulp.src srcdata.bower
    .pipe cssFilter
    .pipe gulp.dest(pub_dir+'/vendors')

gulp.task 'move-vendorjs', () ->
  gulp.src srcdata.vendorjs
    .pipe gulp.dest(pub_dir+'/scripts/vendors')

gulp.task 'move-resources', () ->
  gulp.src srcdata.resource
    .pipe gulp.dest(pub_dir+'/resources')

gulp.task 'webserver', () ->
  gulp.src pub_dir
    .pipe server(livereload:true)

gulp.task 'test', () ->
  gulp.src srcdata.tests, {read:false}
    .pipe mocha reporter: 'list'
  #mocha --compilers coffee:coffee-script/register source/coffee/tests
gulp.task 'compile', [
  'test'
  'compile-js'
  'compile-css'
  'compile-html'
  'move-vendors'
  'move-vendorjs'
  'move-resources'
]
gulp.task 'watch', () ->
  gulp.watch srcdata.tests, ['test']
  gulp.watch srcdata.coffee, ['test']
  gulp.watch srcdata.stylus, ['compile-css']
  gulp.watch srcdata.coffee, ['compile-js']
  gulp.watch srcdata.jade, ['compile-html']
  gulp.watch srcdata.bower, ['move-vendors']
  gulp.watch srcdata.vendorjs, ['move-vendorjs']

gulp.task 'default', [
  'compile'
  'watch'
  'webserver'
]
