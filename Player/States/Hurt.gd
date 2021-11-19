extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "hurt"
	SpriteAnim.play("hurt")
	# TODO
