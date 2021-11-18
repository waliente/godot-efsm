extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "run"
	Player.update_direction()
	AnimatedSprite.play("run")
	Player.velocity.x = lerp(Player.velocity.x, Player.direction * Player.speed, Player.acceleration)
	
	# go to IDLE state
	if Player.direction == 0:
		Player.current_state = Player.states[states.IDLE]
	
	# go to ATTACK state
	if Input.is_action_just_pressed("attack"):
		Player.current_state = Player.states[states.ATTACK1]
	
	# go to JUMP state
	if Input.is_action_just_pressed("jump"):
		Player.current_state = Player.states[states.JUMP]
	
	# go to SLIDE state
	if Input.is_action_just_pressed("down") and Player.direction != 0:
		Player.current_state = Player.states[states.SLIDE]
	
	# go to DASH state
	if Input.is_action_just_pressed("dash") and Player.can_dash:
		Player.current_state = Player.states[states.DASH]
