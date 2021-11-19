extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "die"
	SpriteAnim.play("die")
	# TODO
