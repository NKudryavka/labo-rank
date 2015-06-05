gulp = require "gulp"
plumber = require "gulp-plumber"
uglify = require "gulp-uglify"
coffee = require "gulp-coffee"
sourcemaps = require "gulp-sourcemaps"
#rename = require "gulp-rename"
concat = require "gulp-concat"
fs = require "fs"
path = require "path"

src = 
	coffee: "public-coffee/"

dest = 
	js: "public/js"

childDir = (target, task) ->
	files = fs.readdirSync target
	dirs = files.filter (v) -> fs.statSync(path.join(target, v)).isDirectory()
	dirs.push("")
	for dir in dirs
		task dir
	

gulp.task "js", ->
	childDir src.coffee, (dir) ->
		gulp.src path.join(src.coffee, dir, "*.coffee")
			.pipe plumber()
			.pipe sourcemaps.init()
			.pipe concat (if dir then dir else "script") + ".min.js"
			.pipe coffee()
			.pipe uglify()
			.pipe sourcemaps.write "./map"
			.pipe gulp.dest dest.js

gulp.task "watch", ->
	gulp.watch [path.join(src.coffee, "**/*.coffee"), path.join(src.coffee, "*.coffee")] , ["js"]

gulp.task "default", ["js"]