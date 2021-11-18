extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "jump"
	AnimatedSprite.play("jump")
	Player.update_direction()
	Player.velocity.x = lerp(Player.velocity.x, Player.direction * Player.speed, Player.acceleration)
	Player.velocity.y = Player.jump_speed
	
	if Player.velocity.y <= Player.jump_speed:
		Player.current_state = Player.states[states.FALL]
