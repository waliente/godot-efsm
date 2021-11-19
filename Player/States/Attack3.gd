extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "attack 3"
	SpriteAnim.play("attack1")
	Player.velocity.x = lerp(Player.velocity.x, 0, Player.friction)
