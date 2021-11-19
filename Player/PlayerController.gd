extends KinematicBody2D

export (int) var speed = 120
export (int) var jump_speed = -220
export (int) var gravity = 420

var velocity = Vector2.ZERO
var attack_points = 3
var can_dash = true
var direction = 1

export (float,0,1.0) var friction = 0.1
export (float,0,1.0) var acceleration = 0.25

onready var state = get_node("States").states
onready var previous_state = get_node("States").previous_state
onready var current_state = get_node("States").current_state


func update_state(new_state):
	previous_state = current_state
	current_state = new_state
	match(new_state):
		state.IDLE:
			$States/Idle.execute()
		state.RUN:
			$States/Run.execute()
		state.JUMP:
			$States/Jump.execute()
		state.FALL:
			$States/Fall.execute()
		state.ATTACK1:
			$AnimatedSprite.play("attack1")
		state.ATTACK2:
			$AnimatedSprite.play("attack2")
		state.CROUCH:
			$States/Crouch.execute()
		state.SLIDE:
			$States/Slide.execute()
		state.DASH:
			$States/Dash.execute()
		state.HURT:
			$AnimatedSprite.play("hurt")
		state.DIE:
			$AnimatedSprite.play("die")


func get_input():
	var dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)


func update_movement(delta):
	if -20 <= velocity.x and velocity.x <= 20:
		update_state(state.IDLE)
	elif velocity.x != 0 and Input.is_action_just_pressed("down"):
		update_state(state.SLIDE)
	elif velocity.x != 0:
		update_state(state.RUN)
	
	if is_on_floor() and current_state != state.SLIDE:
		if Input.is_action_just_pressed("jump"):
			update_state(state.JUMP)
		if Input.is_action_pressed("down"):
			update_state(state.CROUCH)
		if Input.is_action_just_pressed("dash") and can_dash:
			update_state(state.DASH)
	
	## JUMP & FALL ##
	if not is_on_floor():
		if velocity.y < jump_speed:
			update_state(state.JUMP)
		else:
			update_state(state.FALL)
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func update_attack():
	if Input.is_action_just_pressed("attack") and attack_points == 3:
		$AttackResetTimer.start()
		velocity.x = 0
		current_state = state.ATTACK1
		attack_points -= 1
	elif Input.is_action_just_pressed("attack") and attack_points == 2:
		$AttackResetTimer.start()
		velocity.x = 0
		current_state = state.ATTACK2
		attack_points -= 1
	elif Input.is_action_just_pressed("attack") and attack_points == 1:
		$AttackResetTimer.start()
		velocity.x = 0
		current_state = state.ATTACK1
		attack_points -= 1


func update_facing():
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false


func hurt():
	pass


func die():
	pass


func update_direction():
	direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	return direction


func _physics_process(delta):
	update_movement(delta)
	update_attack()
	update_facing()


func _on_AnimatedSprite_animation_finished():
	if current_state == state.ATTACK1 || current_state == state.ATTACK2 || current_state == state.DASH || current_state == state.SLIDE:
		update_state(state.IDLE)
	if current_state == state.JUMP:
		update_state(state.FALL)


func _on_AttackResetTimer_timeout():
	attack_points = 3


func _on_DashResetTimer_timeout() -> void:
	can_dash = true
