extends Area2D

const PLAYER_COLLISION_BIT = 1

func _on_body_entered(body: Player):
    body.dark_timer = body.max_dark_time
    $ActivateSound.play()
    set_active(false)


func set_active(active: bool):
    visible = active
    set_collision_mask_bit(PLAYER_COLLISION_BIT, active)
