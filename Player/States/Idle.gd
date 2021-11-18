extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "idle"
	Player.update_direction()
	AnimatedSprite.play("idle")
	Player.velocity.x = lerp(Player.velocity.x, 0, Player.friction)
	
	if -20 <= Player.velocity.x and Player.velocity.x <= 20:
		Player.velocity.x = 0
	
	# go to JUMP state
	if Input.is_action_just_pressed("jump"):
		Player.current_state = Player.states[states.JUMP]
	
	# go to CROUCH state
	if Input.is_action_pressed("down"):
		Player.current_state = Player.states[states.CROUCH]
	
	# go to ATTACK state
	if Input.is_action_just_pressed("attack"):
		Player.current_state = Player.states[states.ATTACK1]

	# go to RUN state
	if Player.direction != 0:
		Player.current_state = Player.states[states.RUN]
