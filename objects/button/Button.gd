extends StaticBody2D

signal pressed

export (Texture) var pressed_image

const LIGHT_COLLISION_BIT = 0
const PLAYER_COLLISION_BIT = 1
const DARK_COLLISION_BIT = 2
const ENEMIES_COLLISION_BIT = 3
const BOXES_COLLISION_BIT = 4

var has_been_pressed := false

func _on_pressed(_body: Node) -> void:
    if not has_been_pressed:
        emit_signal("pressed")
        $ActivateSound.play()
        $Sprite.set_texture(pressed_image)
        has_been_pressed = true

func set_active(active: bool) -> void:
    $Area2D.set_collision_mask_bit(PLAYER_COLLISION_BIT, active)
    set_collision_mask_bit(PLAYER_COLLISION_BIT, active)
    set_collision_layer_bit(LIGHT_COLLISION_BIT, active)
    set_collision_layer_bit(DARK_COLLISION_BIT, active)
