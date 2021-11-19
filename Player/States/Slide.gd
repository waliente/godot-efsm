extends States

onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "slide"
	SpriteAnim.play("slide")
