extends Area2D

const PLAYER_COLLISION_BIT = 1

func set_active(active: bool) -> void:
    set_collision_mask_bit(PLAYER_COLLISION_BIT, active)
