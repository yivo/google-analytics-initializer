gulp   = require('gulp')
coffee = require('gulp-coffee')

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ->
  gulp.src('source/google-analytics-initializer.coffee')
    .pipe gulp.dest('build')
    .pipe coffee()
    .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']
