extends Node2D

class_name LevelManager

export var next_level := 'Level2'

onready var DimensionManager = preload("res://scripts/DimensionManager.gd")
onready var Player = preload("res://characters/player/Player.gd")
onready var HUD = preload("res://ui/HUD.gd")

onready var dark_level: DimensionManager = $Dark
onready var light_level: DimensionManager = $Light
onready var player: Player = $Player
onready var hud: HUD = $HUD

var in_light := false


func _ready() -> void:
    reset_player()


func swap_dimension():
    in_light = !in_light
    light_level.set_active(in_light)
    dark_level.set_active(!in_light)
    player.set_dimension(in_light)
    hud.set_dimension(in_light)


func reset_player():
    in_light = false
    player.reset_position()
    swap_dimension()


func _on_end_portal_entered(_body: Node):
    var _ret = get_tree().change_scene("res://levels/"+next_level+".tscn")


func _on_player_dark_time_remaining(time: float, _max_time: float):
    if time <= 0:
        reset_player()
