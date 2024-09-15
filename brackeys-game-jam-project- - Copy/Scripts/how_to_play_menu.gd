extends Control


func _on_how_to_play_back_button_pressed() -> void:
	print("Back pressed")
	get_tree().change_scene_to_file("res://Scenes/Main Menu.tscn")
