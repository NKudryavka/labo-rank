router = (require "express").Router()
user = require "../modules/user"
laboratory = require "../modules/laboratory"
point = require "../modules/point"

# before相当
router.use (req, res, next) ->
    user.check req.cookies.id, (result) ->
        unless result
            res.redirect "/register/"
        else
            next()

router.get "/labolist", (req, res) ->
    res.send JSON.stringify laboratory.getList()

router.get "/points", (req, res) ->
    point.getAll (data) ->
        res.send JSON.stringify data

module.exports = router