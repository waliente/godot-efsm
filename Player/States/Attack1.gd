extends States

onready var StateLabel = get_node("../../StateLabel")
onready var AttackResetTimer = get_node("../../AttackResetTimer")

func execute():
	StateLabel.text = "attack 1"
	AnimatedSprite.play("attack1")
	Player.velocity.x = lerp(Player.velocity.x, 0, Player.friction)
	
	if AnimatedSprite.frame >= 5:
		# go to ATTACK2 state
		if Input.is_action_just_pressed("attack"):
			Player.current_state = Player.states[states.ATTACK2]
