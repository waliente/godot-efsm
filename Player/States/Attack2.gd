extends States

onready var StateLabel = get_node("../../StateLabel")
onready var AttackResetTimer = get_node("../../AttackResetTimer")

func execute():
	StateLabel.text = "attack 2"
	AnimatedSprite.play("attack2")
	Player.velocity.x = lerp(Player.velocity.x, 0, Player.friction)
	
	# go to ATTACK3 state
	if AnimatedSprite.frame >= 3:
		if Input.is_action_just_pressed("attack"):
			Player.current_state = Player.states[states.ATTACK3]
