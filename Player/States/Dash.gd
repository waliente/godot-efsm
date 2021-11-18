extends States

onready var DashResetTimer = get_node("../../DashResetTimer")
onready var StateLabel = get_node("../../StateLabel")

func execute():
	StateLabel.text = "dash"
	DashResetTimer.start()
	AnimatedSprite.play("dash")
	Player.can_dash = false
	
	# go to JUMP state
	if Input.is_action_just_pressed("jump"):
		Player.current_state = Player.states[states.JUMP]
