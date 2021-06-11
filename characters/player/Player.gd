extends KinematicBody2D


export var move_speed := 200.0
export var jump_factor := 0.4
export var jump_pressed_remember_time := 0.1
export var grounded_remember_time := 0.1

var _velocity := Vector2.ZERO
var _grounded_remember := 0.0
var _jump_remember := 0.0
var _facing_right := true

onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var jump_speed: float = ProjectSettings.get_setting("physics/2d/default_gravity") * jump_factor
onready var sprite: Sprite = $Sprite


func _physics_process(delta: float) -> void:
    _grounded_remember -= delta
    _jump_remember -= delta

    if is_on_floor():
        _grounded_remember = grounded_remember_time

    if Input.is_action_just_pressed("jump"):
        _jump_remember = jump_pressed_remember_time

    var is_jumping := (_grounded_remember > 0) and (_jump_remember > 0)
    if is_jumping:
        _grounded_remember = 0
        _jump_remember = 0

    var is_jump_interrupted := Input.is_action_just_released("jump") and _velocity.y < 0.0

    var direction := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

    flip_if_necessary(direction)
    _velocity = calculate_velocity(_velocity, direction, is_jumping, is_jump_interrupted)
    _velocity = move_and_slide(_velocity, Vector2.UP)


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
    if (direction > 0 and not _facing_right) or (direction < 0 and _facing_right):
        _facing_right = not _facing_right
        sprite.flip_h = not _facing_right
