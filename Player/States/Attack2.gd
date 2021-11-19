extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "attack 2"
	SpriteAnim.play("attack2")
	Player.velocity.x = lerp(Player.velocity.x, 0, Player.friction)
	
	# go to ATTACK3 state
	if SpriteAnim.frame >= 3:
		if Input.is_action_just_pressed("attack"):
			Player.current_state = Player.states[states.ATTACK3]
