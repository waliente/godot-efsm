extends KinematicBody2D

export (int) var speed = 120
export (int) var jump_speed = -220
export (int) var gravity = 420
export (float,0,1.0) var friction = 0.1
export (float,0,1.0) var acceleration = 0.25

const FLOOR_NORMAL = Vector2.UP

var velocity = Vector2.ZERO
var can_dash = true
var direction = 0
var max_hp = 100.0
var current_hp = 100.0

onready var statesEnum = get_node("States").states
var current_state
var states = {}

func _ready() -> void:
	states = {
		statesEnum.IDLE: $States/Idle,
		statesEnum.RUN: $States/Run,
		statesEnum.JUMP: $States/Jump,
		statesEnum.FALL: $States/Fall,
		statesEnum.ATTACK1: $States/Attack1,
		statesEnum.ATTACK2: $States/Attack2,
		statesEnum.ATTACK3: $States/Attack3,
		statesEnum.CROUCH: $States/Crouch,
		statesEnum.SLIDE: $States/Slide,
		statesEnum.DASH: $States/Dash,
		statesEnum.HURT: $States/Hurt,
		statesEnum.DIE: $States/Die
	}
	
	current_state = states[statesEnum.IDLE]


func update_state():
	current_state.execute()


func update_direction():
	direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	if direction < 0:
		$AnimatedSprite.flip_h = true
	if direction > 0:
		$AnimatedSprite.flip_h = false


func apply_gravity(delta):
	velocity.y += gravity * delta


func _physics_process(delta):
	update_state()
	apply_gravity(delta)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func _on_AnimatedSprite_animation_finished():
	if current_state == states[statesEnum.ATTACK1] || current_state == states[statesEnum.ATTACK2] || current_state == states[statesEnum.ATTACK3] || current_state == states[statesEnum.DASH] || current_state == states[statesEnum.SLIDE]:
		current_state = states[statesEnum.IDLE]


func _on_DashResetTimer_timeout():
	can_dash = true
