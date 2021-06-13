extends Node2D

class_name DimensionManager

signal end_portal_entered

onready var walls: TileMap = $Walls

export var light := true

var tutorial_texts = []
var light_seeds = []
var enemies = []
var interactables = []

const PLAYER_COLLISION_BIT = 1


func _ready() -> void:
    var tutorial_parent = get_node_or_null("Tutorial")
    if tutorial_parent:
        tutorial_texts = tutorial_parent.get_children()

    var enemies_parent = get_node_or_null("Enemies")
    if enemies_parent:
        enemies = enemies_parent.get_children()
        for enemy in enemies:
            enemy.set_dimension(light)

    var light_seeds_parent = get_node_or_null("LightSeeds")
    if light_seeds_parent:
        light_seeds = light_seeds_parent.get_children()

    var interactables_parent = get_node_or_null("Interactables")
    if interactables_parent:
        interactables = interactables_parent.get_children()


func set_active(active: bool) -> void:
    visible = active
    walls.set_collision_mask_bit(PLAYER_COLLISION_BIT, active)
    walls.set_occluder_light_mask(1 if active else 0)

    for tutorial_text in tutorial_texts:
        tutorial_text.visible = active

    for enemy in enemies:
        enemy.set_alive(active)

    for light_seed in light_seeds:
        light_seed.set_active(active)

    for interactable in interactables:
        interactable.set_active(active)


func _on_end_portal_entered(body: Node) -> void:
    emit_signal("end_portal_entered", body)
