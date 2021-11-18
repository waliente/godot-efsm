extends Control



func _on_ExitButton_pressed() -> void:
	get_tree().quit()


func _on_PlayButton_pressed() -> void:
	get_tree().change_scene("res://LevelScenes/Level1.tscn")
