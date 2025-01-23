extends Area2D
const MAIN_MENU ="res://UI/MainMenu.tscn"

func _on_area_entered(area: Area2D) -> void:
	get_tree().change_scene_to_file(MAIN_MENU)
