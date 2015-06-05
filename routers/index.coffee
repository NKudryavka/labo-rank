router = (require "express").Router()
render = require "../modules/render"
user = require "../modules/user"

router.get "/", (req, res) ->
    user.check req.cookies.id, (result) ->
        if result
            render res, "index/index", 
                pagetitle: "トップ"
                appName: "index"
                studentId: req.cookies.id
        else
            res.redirect "/register/"
            res.end()

module.exports = router