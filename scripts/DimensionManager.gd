extends Node2D

class_name DimensionManager

onready var walls: TileMap = $Walls

const PLAYER_COLLISION_BIT = 1

func set_active(active: bool) -> void:
    visible = active
    walls.set_collision_mask_bit(PLAYER_COLLISION_BIT, active)
