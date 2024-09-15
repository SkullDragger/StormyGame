extends Node3D


func _on_in_game_back_button_pressed() -> void:
	print("Back pressed")
	get_tree().change_scene_to_file("res://Scenes/Main Menu.tscn")
