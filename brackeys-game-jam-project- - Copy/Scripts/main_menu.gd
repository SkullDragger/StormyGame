extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	print("Play pressed")
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")
	

func _on_how_to_play_pressed() -> void:
	print("How To Play pressed")
	get_tree().change_scene_to_file("res://Scenes/How To Play Menu.tscn")


func _on_exit_pressed() -> void:
	print("Exit pressed")
	get_tree().quit()



func _on_credits_pressed() -> void:
	print("Credits pressed")
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
