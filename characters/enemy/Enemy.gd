extends KinematicBody2D

export var speed := 30.0
export var direction := -1

const LIGHT_COLLISION_BIT = 0
const PLAYER_COLLISION_BIT = 1
const DARK_COLLISION_BIT = 2
const ENEMY_COLLISION_BIT = 3

var velocity := Vector2.ZERO
var alive := true

onready var sprite: Sprite = $Sprite
onready var collision: CollisionShape2D = $CollisionShape2D
onready var hitbox: Area2D = $HitBox
onready var hurtbox: Area2D = $HurtBox
onready var floor_check: RayCast2D = $FloorCheck
onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta: float) -> void:
    if not (alive):
        return

    if is_on_wall() or not (floor_check.is_colliding() and is_on_floor()):
        direction *= -1
        update_direction()

    velocity.x = direction * speed
    velocity.y += gravity * get_physics_process_delta_time()

    velocity = move_and_slide(velocity, Vector2.UP)


func set_alive(new_alive: bool):
    alive = new_alive
    visible = alive
    hitbox.set_collision_mask_bit(PLAYER_COLLISION_BIT, alive)
    hitbox.set_collision_layer_bit(ENEMY_COLLISION_BIT, alive)
    hurtbox.set_collision_mask_bit(PLAYER_COLLISION_BIT, alive)
    hurtbox.set_collision_layer_bit(ENEMY_COLLISION_BIT, alive)
    set_collision_layer_bit(ENEMY_COLLISION_BIT, alive)


func set_dimension(in_light: bool):
    set_collision_mask_bit(LIGHT_COLLISION_BIT, in_light)
    set_collision_mask_bit(DARK_COLLISION_BIT, !in_light)
    floor_check.set_collision_mask_bit(LIGHT_COLLISION_BIT, in_light)
    floor_check.set_collision_mask_bit(DARK_COLLISION_BIT, !in_light)


func update_direction() -> void:
    sprite.flip_h = (direction == 1)
    floor_check.position.x = direction * collision.shape.get_extents().x


func _on_HurtBox_body_entered(body: Node) -> void:
    body.dark_timer = body.max_dark_time
    body.bounce()
    set_alive(false)
    $HurtSound.play()


func _on_HitBox_body_entered(body: Player) -> void:
    if alive and body.has_method("kill"):
        body.kill()
