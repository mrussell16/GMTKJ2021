extends Node2D

class_name DimensionManager

signal end_portal_entered

onready var walls: TileMap = $Walls

var tutorial: CanvasLayer
var tutorial_texts = []

const PLAYER_COLLISION_BIT = 1

func _ready() -> void:
    tutorial = get_node("Tutorial")
    if tutorial:
        tutorial_texts = tutorial.get_children()

func set_active(active: bool) -> void:
    visible = active
    walls.set_collision_mask_bit(PLAYER_COLLISION_BIT, active)
    walls.set_occluder_light_mask(1 if active else 0)
    for tutorial_text in tutorial_texts:
        tutorial_text.visible = active

func _on_end_portal_entered(body: Node) -> void:
    emit_signal("end_portal_entered", body)
