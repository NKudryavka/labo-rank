angular.module "index", ["common"]
.service "labolist", ["$rootScope", "$http", "events", ($scope, $http, events) ->
    $http.get "/api/labolist"
    .success (data, status, headers, config) ->
        $scope.$broadcast events.labolist.load, data
    .error (data, status, headers, config) ->
        alert "Error: " + status
]
.service "points", ["$rootScope", "$http", "events", ($scope, $http, events) ->
    $http.get "/api/points"
    .success (data, status, headers, config) ->
        $scope.$broadcast events.points.load, data
    .error (data, status, headers, config) ->
        alert "Error: " + status
]
.filter "choiceFilter", [ ->
    filterFactory = (filterObj) ->
        if !filterObj or !filterObj.choice
            -> true
        else if /^B\d$/.test filterObj.choice.id
            num = parseInt filterObj.choice.id.slice 1
            (o) -> num*100 < o.choice.id < (num+1)*100
        else
            (o) -> o.choice.id == filterObj.choice.id

    (input, filterObj) ->
        unless input then return []
        res = []
        filter = filterFactory filterObj
        for o in input
            res.push o if filter o
        res
]
.directive "stats", ["events", (events) ->
    histPosition = 2
    (scope, $el, attrs) ->
        svg = d3.select($el.children()[histPosition]).append("svg")
            .attr "width", "100%"
            .attr "height", "200px"
        bins = rectX = rectW = null

        points = []
        list = []

        scope.step = 5

        drawHist = ->
            svg.selectAll("*").remove()
            unless points.length then return
            histogram = d3.layout.histogram().range([0,150]).bins bins

            data = histogram list
            max = Math.max.apply(null, data.map (v) -> v.length)

            getY = (y) ->
                y * (100/max)
            
            g = svg.selectAll("rect").data(histogram(list)).enter()
            g.append "rect"
                .attr "x", (d, i) -> (i*rectX) + "%"
                .attr "y", (d) -> (100 - getY d.y) + "%"
                .attr "width", -> rectW + "%"
                .attr "height", (d) -> (getY d.y) + "%"
                .attr "fill", "#3af"
            g.append "text"
                .text (d) -> d.x + "～"　if d.y
                .attr "x", (d, i) -> (i*rectX + rectW/2) + "%"
                .attr "y", (d, i) -> if i%2 then "195px" else "180px"
                .attr "width", rectW + "%"
                .attr "text-anchor", "middle"

        handler = (e, tp) ->
            points = tp if Array.isArray tp
            list = []
            sum = 0
            for p in points
                list.push(p.point)
                sum += p.point
            scope.average = sum/list.length
            median = list[parseInt(list.length/2)]
            if list.length and !(list.length % 2)
                median = (median + list[parseInt(list.length/2) - 1]) /2
            scope.median = median

            drawHist()

        scope.$on events.points.change, handler
        scope.$on events.points.load, handler
        scope.$watch "step", (step) ->
            bins = []
            for i in [60..120] by parseFloat(step)
                bins.push(i)
            rectX = 100/(bins.length - 1)
            rectW = 0.9*rectX
            drawHist()
]
.controller "MainController", ["$scope", "$filter", "events", "labolist", "points", ($scope, $filter, events) ->
    $scope.overlay = true
    flags =
        labolist: true
        points: true
    $scope.filter = null
    points = null
    choiceFilter = $filter("choiceFilter")
    $scope.$on events.labolist.load, (e, v) ->
        $scope.labolist = v
        flags.labolist = false
        $scope.overlay = flags.points

    $scope.$on events.points.load, (e, v) ->
        points = v
        $scope.points = choiceFilter(points, $scope.filter)
        flags.points = false
        $scope.overlay = flags.labolist

    $scope.$watch "filter", (val) ->
        tp = choiceFilter points, $scope.filter
        $scope.points = tp
        $scope.$emit events.points.change, tp
    , true
]