extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "hurt"
	AnimatedSprite.play("hurt")
	# TODO
