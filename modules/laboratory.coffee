config = require "../config"

labolist = config.labolist
getCache = {}

exports.get = (id) ->
    index = getCache[id]
    if index?
        return labolist[index]
    else
        for lab, ind in labolist
            if lab.id == id
                getCache[id] = ind
                return lab
    null
        

exports.getList = ->
    labolist
        
    