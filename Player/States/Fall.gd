extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "fall"
	Player.update_direction()
	Player.velocity.x = lerp(Player.velocity.x, Player.direction * Player.speed, Player.acceleration)
	AnimatedSprite.play("fall")
	
	if Player.is_on_floor():
		Player.current_state = Player.states[states.IDLE]
