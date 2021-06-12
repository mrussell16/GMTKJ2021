extends RigidBody2D


var in_light := false

var initial_position := Vector2.ZERO
var light_position := Vector2.ZERO
var dark_position := Vector2.ZERO


func _ready() -> void:
    initial_position = position
    add_to_group("movables")


func _physics_process(_delta: float) -> void:
    if position.y < initial_position.y:
        initial_position.y = position.y
        print("May have moved into floor")


func set_dimension(light: bool) -> void:
    if in_light:
        light_position = position
        dark_position = position

    in_light = light
    initial_position = position
