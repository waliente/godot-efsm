extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "die"
	AnimatedSprite.play("die")
	# TODO
