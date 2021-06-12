extends RigidBody2D


var light_position := Vector2.ZERO
var dark_position := Vector2.ZERO
var initial_position := Vector2.ZERO
var in_light := true
var moved := false


func _ready() -> void:
    light_position = global_position
    dark_position = global_position
    initial_position = global_position
    add_to_group("movables")


func set_dimension(light: bool) -> void:
    if in_light:
        light_position = global_position

        if moved:
            dark_position = light_position
    else:
        dark_position = global_position

    in_light = light
    initial_position = global_position
    moved = false

    if in_light:
        global_position = light_position
    else:
        global_position = dark_position


func set_moved():
    moved = true
