extends Control

# 加载场景
const GAME_SCENE = "res://Map/地图chapter1.tscn"

func _ready():
	# 获取图片尺寸并设置窗口大小
	var screen_size = $TextureRect.texture.get_size()
	get_window().set_size(screen_size)



func _on_button_game_start_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE) # Replace with function body.


func _on_button_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.
