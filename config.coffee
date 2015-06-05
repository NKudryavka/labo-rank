path = require "path"

module.exports =
    # mongodb connection url
    mongodburl: "Your Mongodb Url Here"
    # path to view dir
    viewpath: path.join __dirname, "views/"

    # List of laboratory
    labolist: [
        {id: "B1", name: "---B1---"},
        {id: 101, name: "笠井研究室"},
        {id: 102, name: "山田研究室"},
        {id: 103, name: "府川研究室"},
        {id: 104, name: "植松/松本研究室"},
        {id: 105, name: "尾形研究室"},
        {id: 106, name: "山岡研究室"},
        {id: 107, name: "飯田研究室"},
        {id: 108, name: "西原研究室"},
        {id: 109, name: "伊東研究室"},

        {id: "B2", name: "---B2---"},
        {id: 201, name: "金子（晴）研究室"},
        {id: 202, name: "吉瀬研究室"},
        {id: 203, name: "一色/原研究室"},
        {id: 204, name: "上野研究室"},
        {id: 205, name: "高木研究室"},
        {id: 206, name: "高橋研究室"},
        {id: 207, name: "杉野研究室"},

        {id: "B3", name: "---B3---"},
        {id: 301, name: "横田研究室"},
        {id: 302, name: "佐伯研究室"},
        {id: 303, name: "西崎研究室"},
        {id: 304, name: "渡部研究室"},
        {id: 305, name: "権藤研究室"},
        {id: 306, name: "小林研究室"},
        {id: 307, name: "宮崎研究室"},

        {id: "B4", name: "---B4---"},
        {id: 401, name: "徳永研究室"},
        {id: 402, name: "篠田研究室"},
        {id: 403, name: "秋山研究室"},
        {id: 404, name: "室田研究室"},
        {id: 405, name: "村田研究室"},
        {id: 406, name: "藤井研究室"},
        {id: 407, name: "関嶋研究室"},
        {id: 408, name: "石田研究室"},
        {id: 409, name: "奥村/高村研究室"},

        {id: "B5", name: "---B5---"},
        {id: 501, name: "亀井研究室"},
        {id: 502, name: "小池（英）研究室"},
        {id: 503, name: "熊澤研究室"},
        {id: 504, name: "小林/篠崎研究室"},
        {id: 505, name: "長橋研究室"},
        {id: 506, name: "佐藤/長谷川（晶）研究室"},
        {id: 507, name: "小池（康）研究室"},
        {id: 508, name: "内川研究室"},
        {id: 509, name: "金子（寛）研究室"},
        {id: 510, name: "長谷川（修）研究室"},
        {id: 511, name: "大山/小尾研究室"},
        {id: 512, name: "山口研究室"},
    ]
