extends Area2D

signal swap_dimension

var player_inside: bool = false

func _process(_delta: float) -> void:
    if player_inside and Input.is_action_just_pressed("swap_dimension"):
        emit_signal("swap_dimension")

func _on_body_entered(_body: Node):
    player_inside = true

func _on_body_exited(_body: Node):
    player_inside = false
