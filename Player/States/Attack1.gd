extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "attack 1"
	SpriteAnim.play("attack1")
	Player.velocity.x = lerp(Player.velocity.x, 0, Player.friction)
	
	if SpriteAnim.frame >= 5:
		# go to ATTACK2 state
		if Input.is_action_just_pressed("attack"):
			Player.current_state = Player.states[states.ATTACK2]
