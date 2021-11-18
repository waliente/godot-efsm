extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	Player.update_direction()
	StateLabel.text = "crouch"
	Player.velocity.x = 0
	AnimatedSprite.play("crouch")
	
	# go to IDLE state
	if Input.is_action_just_released("down"):
		Player.current_state = Player.states[states.IDLE]
