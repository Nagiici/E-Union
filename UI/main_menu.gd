extends Control

# 加载场景
const GAME_SCENE = "res://Map/地图chapter1.tscn"


func _ready():
	# 连接窗口大小变化的信号
	get_window().connect("size_changed", Callable(self, "_on_window_resized"))
	_on_window_resized()
	


func _on_window_resized():
	var viewport_size = get_viewport_rect().size
	$TextureRect.set_size(viewport_size)
	$TextureRect.set_position(Vector2.ZERO)

	# 获取TextureRect的大小
	var tex_size = $TextureRect.size

	# 设置 GridContainer 的位置始终保持在右下角
	var grid_container = $TextureRect/GridContainer
	grid_container.set_position(Vector2(tex_size.x - grid_container.size.x - 150, tex_size.y - grid_container.size.y - 180))
# 设置按钮大小，基于TextureRect的比例
	#var button_size = Vector2(tex_size.x * 0.2, tex_size.y * 0.05)
	#$TextureRect/GridContainer/Game_Start.set_size(button_size)
	#$TextureRect/GridContainer/Quit.set_size(button_size)


	## 参考原始图片尺寸 744x779 进行比例调整
	#var tex_size = $TextureRect.size
	#var scale_factor_x = tex_size.x / 744.0
	#var scale_factor_y = tex_size.y / 779.0
	#var Game_Start = $TextureRect/Game_Start
	#var Quit = $TextureRect/Quit
#
	## 设置按钮大小和位置，按比例缩放
	#Game_Start.set_size(Vector2(tex_size.x * 0.02, tex_size.y * 0.005))
	#Game_Start.set_position(Vector2(tex_size.x * 0.55, tex_size.y * 0.78))
#
	#Quit.set_size(Vector2(tex_size.x * 0.02, tex_size.y * 0.005))
	#Quit.set_position(Vector2(tex_size.x * 0.55, tex_size.y * 0.92))




func _on_button_game_start_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE) # Replace with function body.


func _on_button_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.
