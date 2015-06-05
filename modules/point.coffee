validation = require "./validation"
users = (require "./data") "users"
laboratory = require "./laboratory"

exports.getAll = (callback) ->
    users.getAll().onFulfill (data) ->
        result = []
        for v in data
            result.push
                point: v.point
                choice: laboratory.get v.choice

        result.sort (a, b) ->
            b.point - a.point

        callback result