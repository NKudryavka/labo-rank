laboratory = require "./laboratory"

funcs = 
    studentId: (str) ->
        exp = /^([0-9]{2})[B_ -]?([0-9]{5})$/
        res = exp.exec str

        unless res then return false
        str = res[1] + res[2]

        confDigit = parseInt str.charAt 6
        res = 0
        for i in [0...6]
            res += (i+2) * parseInt str.charAt i

        res %= 11
        if res >= 10 then res -= 10

        if confDigit == res
            str
        else
            false

    point: (str) ->
        point = parseFloat str

        if (not isNaN point) and 0 <= point <= 120
            Math.round(point*100) / 100
        else
            false

    choice: (str) ->
        id = parseInt str
        if isNaN id then return false
        labo = laboratory.get id
        labo = false unless labo
        labo

messages =
    studentId: "学籍番号が間違えています"
    point: "戦闘力が不正です"
    choice: "志望研究室は選択必須です"

for k, v of funcs
    exports[k] = v

exports.getMessage = (c) ->
    messages[c]
