extends Control

class_name HUD

onready var energy_bar_container: Control = $EnergyBar
onready var energy_bar: TextureRect = $EnergyBar/Bar


func _on_dark_time_remaining(time: float, max_time: float) -> void:
    energy_bar.rect_scale.x = time / max_time


func set_dimension(light: bool) -> void:
    energy_bar_container.visible = !light
