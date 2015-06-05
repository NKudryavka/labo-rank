express = require "express"
app = express()
morgan = require "morgan"
render = require "./modules/render"

ROUTERS = "./routers/"

app.use morgan "combined", {
    immediate: true
    skip: (req, res) ->
        res.statusCode < 400
}

app.set "port", process.env.PORT or 5000
app.set "view engine", "jade";
app.use express.static(__dirname + "/public")
app.use (require "cookie-parser")()
app.use (require "body-parser").json()

getRouter = (r) ->
    require ROUTERS + r

app.use "/register", getRouter "register"
app.use "/api", getRouter "api"
app.use "/", getRouter "index"
app.use (req, res, next) ->
    res.status(404)
    render res, "errors/404",
        pagetitle: "404 Not Found"
        url: req.url

app.use (err, req, res, next) ->
    if err
        console.log err
        res.send "500 Internal Server Error"

app.listen app.get("port"), ->
    console.log "Node app is running at localhost:" + app.get "port"