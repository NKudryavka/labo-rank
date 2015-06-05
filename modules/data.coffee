fs = require "fs"
config = require "../config"
mongoose = require "mongoose"
Schema = mongoose.Schema

mongoose.connect config.mongodburl

usersSchema = new Schema
    studentId: 
        type: [String]
        index: true
    point: Number
    choice: Number
, autoIndex: false

Users = mongoose.model "Users", usersSchema

models =
    users: Users
indexes =
    users: "studentId"

promiseError = (reason) ->
    console.log "Data promise rejected by #{reason}"

mod = (collection) ->
    index = indexes[collection]
    model = models[collection]
    unless model then return null
    put: (key, obj) ->
        where = {}
        where[index] = key
        model.update where, obj, upsert: true
        .exec().onReject(promiseError)
    get: (key) ->
        where = {}
        where[index] = key
        model.findOne where
        .exec().onReject(promiseError)
    getAll: ->
        model.find().exec().onReject(promiseError)
    remove: (key) ->
        where = {}
        where[index] = key
        model.remove where
        .exec().onReject(promiseError)
        
module.exports = mod