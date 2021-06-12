extends Node2D


onready var dark_level: Node2D = $Dark
onready var light_level: Node2D = $Light
onready var player: KinematicBody2D = $Player

const LIGHT_COLLISION_BIT = 1
const DARK_COLLISION_BIT = 3

func _ready() -> void:
    swap_dimension(true)


func swap_dimension(light: bool):
    light_level.visible = light
    player.set_collision_mask_bit(LIGHT_COLLISION_BIT, light)

    dark_level.visible = !light
    player.set_collision_mask_bit(DARK_COLLISION_BIT, !light)
