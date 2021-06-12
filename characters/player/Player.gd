extends KinematicBody2D

class_name Player

signal dark_time_remaining(time, max_time)
signal player_killed

export var move_speed := 200.0
export var jump_factor := 0.4
export var jump_pressed_remember_time := 0.1
export var grounded_remember_time := 0.1
export var max_dark_time := 5.0
export var jump_dark_usage := 0.5
export var reset_cooldown := 0.5

const LIGHT_COLLISION_BIT = 0
const DARK_COLLISION_BIT = 2

var velocity := Vector2.ZERO
var grounded_remember := 0.0
var jump_remember := 0.0
var reset_cooldown_timer := -1.0
var facing_right := true
var dark_timer := max_dark_time
var in_light := true
var bouncing := false
var entry_position := Vector2(52.0, 270.0)

onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var jump_speed: float = ProjectSettings.get_setting("physics/2d/default_gravity") * jump_factor
onready var sprite: Sprite = $Sprite


func _ready() -> void:
    entry_position = position


func _physics_process(delta: float) -> void:
    if grounded_remember >= 0:
        grounded_remember -= delta

    if jump_remember >= 0:
        jump_remember -= delta

    if reset_cooldown_timer >= 0:
        reset_cooldown_timer -= delta
        velocity = calculate_velocity(velocity, 0, false, false)
        velocity = move_and_slide(velocity, Vector2.UP)
        return

    if is_on_floor():
        grounded_remember = grounded_remember_time

    if Input.is_action_just_pressed("jump"):
        jump_remember = jump_pressed_remember_time

    var is_jumping := ((grounded_remember > 0) and (jump_remember > 0)) or bouncing
    if is_jumping:
        grounded_remember = 0
        jump_remember = 0

    var is_jump_interrupted := Input.is_action_just_released("jump") and velocity.y < 0.0

    var direction := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

    if !in_light:
        if direction != 0:
            dark_timer -= delta
        if is_jumping and not bouncing:
            dark_timer -= jump_dark_usage

    flip_if_necessary(direction)
    velocity = calculate_velocity(velocity, direction, is_jumping, is_jump_interrupted)
    velocity = move_and_slide(velocity, Vector2.UP)
    bouncing = false

    if !in_light:
        emit_signal("dark_time_remaining", dark_timer, max_dark_time)


func calculate_velocity(start_velocity: Vector2, direction: float, is_jumping: bool, is_jump_interrupted: bool) -> Vector2:
    var new_velocity := start_velocity
    new_velocity.x = move_speed * direction
    new_velocity.y += gravity * get_physics_process_delta_time()

    if is_jumping:
        new_velocity.y = -jump_speed

    # if direction != 0:
    #     animationPlayer.play("Move")
    # else:
    #     animationPlayer.play("Idle")

    if is_jump_interrupted:
        new_velocity.y = 0

    return new_velocity


func flip_if_necessary(direction: float) -> void:
    if (direction > 0 and not facing_right) or (direction < 0 and facing_right):
        facing_right = not facing_right
        sprite.flip_h = not facing_right


func set_dimension(light: bool) -> void:
    in_light = light
    dark_timer = max_dark_time
    entry_position = position
    set_collision_mask_bit(LIGHT_COLLISION_BIT, in_light)
    set_collision_mask_bit(DARK_COLLISION_BIT, !in_light)


func reset_position() -> void:
    position = entry_position
    velocity = Vector2.ZERO
    reset_cooldown_timer = reset_cooldown


func kill() -> void:
    emit_signal("player_killed")


func bounce() -> void:
    bouncing = true
