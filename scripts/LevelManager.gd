extends Node2D

class_name LevelManager

onready var DimensionManager = preload("res://scripts/DimensionManager.gd")
onready var Player = preload("res://characters/player/Player.gd")

onready var dark_level: DimensionManager = $Dark
onready var light_level: DimensionManager = $Light
onready var player: Player = $Player

var in_light := false
var entry_portal_position := Vector2(52.0, 270.0)


func _ready() -> void:
    reset_player()


func record_portal_position():
    entry_portal_position = player.position


func swap_dimension():
    in_light = !in_light

    if not in_light:
        record_portal_position()

    light_level.set_active(in_light)
    dark_level.set_active(!in_light)
    player.set_dimension(in_light)


func reset_player():
    in_light = false
    player.reset_position(entry_portal_position)
    swap_dimension()


func _on_end_portal_entered(_body: Node):
    print("End level")


func _on_player_dark_time_remaining(time: float):
    if time <= 0:
        reset_player()
