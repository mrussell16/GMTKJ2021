extends Node2D

class_name LevelManager

onready var DimensionManager = preload("res://scripts/DimensionManager.gd")

onready var dark_level: DimensionManager = $Dark
onready var light_level: DimensionManager = $Light
onready var player: KinematicBody2D = $Player

const LIGHT_COLLISION_BIT = 0
const PLAYER_COLLISION_BIT = 1
const DARK_COLLISION_BIT = 2

var in_light: bool = false


func _ready() -> void:
    swap_dimension()


func swap_dimension():
    in_light = !in_light

    light_level.visible = in_light
    player.set_collision_mask_bit(LIGHT_COLLISION_BIT, in_light)
    light_level.walls.set_collision_mask_bit(PLAYER_COLLISION_BIT, in_light)

    dark_level.visible = !in_light
    player.set_collision_mask_bit(DARK_COLLISION_BIT, !in_light)
    dark_level.walls.set_collision_mask_bit(PLAYER_COLLISION_BIT, !in_light)

func _on_end_portal_entered(_body: Node):
    print("End level")
