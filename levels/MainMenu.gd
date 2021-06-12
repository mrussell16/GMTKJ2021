extends Control


onready var play_button: Button = $PlayButton


func _ready() -> void:
    play_button.grab_focus()
