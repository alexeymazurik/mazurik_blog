var gulp    = require('gulp'),
    concat  = require('gulp-concat');

var css_files = [
       'bower_components/bootstrap/dist/css/bootstrap.css'
    ],
    js_files = [
       'bower_components/jquery/dist/jquery.js',
       'bower_components/bootstrap/dist/js/bootstrap.js'
    ],
    font_files = [
       'bower_components/bootstrap/dist/fonts/*'
    ];

gulp.task('styles', function(){
   gulp.src(css_files)
       .pipe(concat('vendor.css'))
       .pipe(gulp.dest('public/assets/css'))
});

gulp.task('fonts', function(){
    gulp.src(font_files)
        .pipe(gulp.dest('public/assets/fonts'))
});

gulp.task('js', function(){
    gulp.src(js_files)
        .pipe(concat('vendor.js'))
        .pipe(gulp.dest('public/assets/js'))
});

gulp.task('default', ['styles', 'fonts', 'js']);
gulp.task('build', ['default']);