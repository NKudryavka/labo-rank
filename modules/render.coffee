config = require "../config"
path = require "path"

module.exports = (res, viewpath, vars) ->
	res.render path.join(config.viewpath, viewpath), vars