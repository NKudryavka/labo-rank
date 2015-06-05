validation = require "./validation"
users = (require "./data") "users"

exports.register = (obj, callback) ->
    result = 
        messages: {}
        result: true

    studentId = obj.studentId
    point = obj.point
    choice = obj.choice

    studentId = validation.studentId(studentId)
    unless studentId
        result.messages.studentId = validation.getMessage "studentId"

    point = validation.point(point)
    unless point
        result.messages.point = validation.getMessage "point"

    choice = validation.choice(choice)
    unless choice
        result.messages.choice = validation.getMessage "choice"

    for v of result.messages
        result.result = false

    unless result.result
        callback result
    else
        result.studentId = studentId
        users.put studentId, 
            studentId: studentId
            point: point
            choice: choice.id
        .onFulfill (data) ->
            callback result

exports.check = (studentId, callback) ->
    if validation.studentId(studentId) 
        users.get(studentId).onFulfill (data) ->
            callback data?
    else
        callback false