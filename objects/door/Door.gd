extends StaticBody2D

const LIGHT_COLLISION_BIT = 0
const DARK_COLLISION_BIT = 2

var is_open := true

func open():
    is_open = true
    visible = false
    set_active(false)

func set_active(active: bool) -> void:
    var enabled := active and not is_open
    set_collision_layer_bit(LIGHT_COLLISION_BIT, enabled)
    set_collision_layer_bit(DARK_COLLISION_BIT, enabled)
