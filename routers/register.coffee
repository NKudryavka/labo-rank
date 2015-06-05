router = (require "express").Router()
render = require "../modules/render"
user = require "../modules/user"
laboratory = require "../modules/laboratory"
validation = require "../modules/validation"

router.get "/", (req, res) ->
    render res, "register/index", 
        pagetitle: "登録"
        appName: "register"
        labolist: laboratory.getList()

router.post "/api/reg", (req, res) ->
    if !req.body.point and !req.body.choice
        user.check req.body.studentId, (result) ->
            r = result: result
            if result
                r.studentId = validation.studentId req.body.studentId
                r.goto = "/"
                res.cookie "id", r.studentId
            else
                r.messages = 
                    point: validation.getMessage "point"
                    choice: validation.getMessage "choice"
                unless validation.studentId req.body.studentId
                    r.messages.studentId = validation.getMessage "studentId" 
            res.send JSON.stringify r
    else
        user.register req.body, (result) ->
            if result.result
                res.cookie "id", result.studentId, expires: new Date(2015, 3, 10)
                result.goto = "/"
            
            res.send JSON.stringify result

module.exports = router;