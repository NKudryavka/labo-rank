switchPage = (url) ->
    location.href = url

angular.module "register",["common"]
.directive "focusSelect", [ ->
    (scope, $e, attrs) ->
        $e.on "click", ->
            this.select()
]
.controller "MainController", ["$scope", "events", ($scope, events) ->
    $scope.overlay = false
    $scope.$on events.overlay.change, (e, val) -> $scope.overlay = val
]
.controller "RegisterForm", ["$scope", "$http", "events", ($scope, $http, events) ->
    $scope.studentId = ""
    $scope.point = ""
    $scope.choce = ""

    $scope.register = ->
        $scope.$emit events.overlay.change, true
        $http.post "api/reg",
            studentId: $scope.studentId
            point: $scope.point
            choice: $scope.choice
        .success (data, status, headers, config) ->
            if data.result
                switchPage data.goto
            else
                $scope.$emit events.overlay.change, false
                $scope.messages = data.messages
        .error (data, status, headers, config) ->
            alert "Error: " + status
]