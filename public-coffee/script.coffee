angular.module "common", []
.directive "overlay", ["events", (events) ->
    events.overlay = change: "overlay:change"
    (scope, $e, attrs) ->
        new Spinner(
            lines: 10
            length: 20
            radius: 15
            trail: 97
            shadow: true
            ).spin($e[0])
]
.value "events",
    overlay:
        change: "overlay:change"
    points:
        load: "points:load"
        change: "points:change"
    labolist:
        load: "labolist:load"