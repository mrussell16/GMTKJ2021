extends Node2D

class_name DimensionManager

signal end_portal_entered

onready var walls: TileMap = $Walls

const PLAYER_COLLISION_BIT = 1

func set_active(active: bool) -> void:
    visible = active
    walls.set_collision_mask_bit(PLAYER_COLLISION_BIT, active)

func _on_end_portal_entered(body: Node) -> void:
    emit_signal("end_portal_entered", body)
